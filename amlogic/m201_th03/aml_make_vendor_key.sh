#!/bin/bash
#
# Copyright (C) 2010 Frank.Chen@amlogic.com
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# Generates public/private key pairs suitable for use in signing
# android .apks and OTA update packages.

SUBJ='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
  cat <<EOF
  
This a device vendor tools.It generates public/private key pairs suitable for 
use in signing android .apks and update packages.

Device vendor

Usage: $0
      -h (--help)
       show usage
      -d 
       delete all keys and certs
      
Generate key pair as releasekey, platform, shared and media which is use to sign code

Creates releasekey.pk8 key and releasekey.x509.pem cert,
        platform.pk8 key and platform.x509.pem cert,
        shared.pk8 key and shared.x509.pem cert,
        media.pk8 key and media.x509.pem cert.  
        
Cert contains the given $SUBJ(edit me).
EOF
  exit 2
fi

if [ "$1" = "-d" ]; then
echo "remove all key pairs"
rm -f releasekey.pk8 releasekey.pem releasekey.x509.pem \
	platform.pk8 platform.pem platform.x509.pem \
	shared.pk8 shared.pem shared.x509.pem \
	media.pk8 media.pem media.x509.pem
	exit 3
fi


function checkexist ()
{
if [[ -e $1.pk8 || -e $1.x509.pem ]]; then
  echo "$1.pk8 and/or $1.x509.pem already exist; please delete them first"
  echo "use "$0" -d to remove them."
  exit 1
fi
}

checkexist releasekey
checkexist platform
checkexist shared
checkexist media

# Use named pipes to connect get the raw RSA private key to the cert-
# and .pk8-creating programs, to avoid having the private key ever
# touch the disk.

tmpdir=$(mktemp -d)
trap 'rm -rf ${tmpdir}; echo; exit 1' EXIT INT QUIT

one=${tmpdir}/one
two=${tmpdir}/two
mknod ${one} p
mknod ${two} p
chmod 0600 ${one} ${two}

read -p "Enter password for '$1' (blank for none; password will be visible): " \
  password

function createkey ()
{
echo "Creating "$1" key......"
( openssl genrsa -3 2048 | tee ${one} > ${two} ) &

openssl req -new -x509 -sha1 -key ${two} -out $1.x509.pem \
  -days 10000 -subj "$2" &

if [ "${password}" == "" ]; then
  echo "creating ${1}.pk8 with no password"
  openssl pkcs8 -in ${one} -topk8 -outform DER -out $1.pk8 -nocrypt
else
  echo "creating ${1}.pk8 with password [${password}]"
  echo $password | openssl pkcs8 -in ${one} -topk8 -outform DER -out $1.pk8 \
    -passout stdin
fi
}

createkey releasekey $SUBJ
createkey platform $SUBJ
createkey shared $SUBJ
createkey media $SUBJ

wait
wait
