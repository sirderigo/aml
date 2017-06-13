#include "bplus_customize.h"

#include "cutils/log.h"

#ifdef HAS_BDROID_BUILDCFG
#include "bdroid_buildcfg.h"
#endif

char * GetDisplayLable()
{
#ifdef HAS_BDROID_BUILDCFG
    char *lable = BTM_DEF_LOCAL_NAME;
#else
	char *lable = "AML-MX";
#endif


    ALOGD("%s: label = %s\n", __FUNCTION__, lable);
	return lable;
}

char * GetFwFullDir()
{
	char *FwFullDir = "/etc/bluetooth/";

    ALOGD("%s: %s\n", __FUNCTION__, FwFullDir);
	return FwFullDir;
}


char * GetFwFilename()
{
	char *FwFilename = "bcm2076b1.hcd";

    ALOGD("%s: FwFilename = %s\n", __FUNCTION__, FwFilename);
	return FwFilename;
}

