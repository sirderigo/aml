#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# BUILD_NUMBER can be customized to project specific version scheme.
# Default scheme uses the date to identify incremental version.



#########################################################################
ifeq ($(BUILD_APK),THAILAND)
export BUILD_NUMBER := M1.TGTM.JCBB.$(shell date +%Y%m%d).09
endif

ifeq ($(BUILD_APK),JIANG_XI_DIAN_XIN)
export BUILD_NUMBER := M1.CZSC.JXDX.$(shell date +%Y%m%d).09
endif

ifeq ($(BUILD_APK),ZHONG_HUA_YUN_HE)
export BUILD_NUMBER := M1.SPSC.JCBB.$(shell date +%Y%m%d).09
endif
ifeq ($(BUILD_APK),ZHONG_HUA_YUN_HE_SHUIPING)
export BUILD_NUMBER := M1C.SPSC.DCBB.$(shell date +%Y%m%d).09
endif
ifeq ($(BUILD_APK),QUAN_ZHOU_DIAN_XIN)
export BUILD_NUMBER := M1.CZSC.QZDX.$(shell date +%Y%m%d).03
endif
#########################################################################

######export BUILD_NUMBER := M1.SPSC.JCBB.08.$(shell date +%Y%m%d)

