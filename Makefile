#
# Copyright (C) 2015 MediaTek Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#

#
# Rissu's changes on 21/11/2024
#
CURRENT_PATH := $(srctree)/$(src)
TOP := $(CURRENT_PATH)
WMT_SRC_FOLDER := $(TOP)/common
TARGET_BUILD_VARIANT := user

export TOP WMT_SRC_FOLDER TARGET_BUILD_VARIANT

# Connectivity combo driver
# If KERNELRELEASE is defined, we've been invoked from the
# kernel build system and can use its language.
subdir-ccflags-y += -I$(srctree)/
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include/clkbuf_v1
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include/clkbuf_v1/$(MTK_PLATFORM)
subdir-ccflags-y += -Werror -I$(srctree)/drivers/misc/mediatek/include/mt-plat/$(MTK_PLATFORM)/include
subdir-ccflags-y += -Werror -I$(srctree)/drivers/misc/mediatek/include/mt-plat
ifeq ($(CONFIG_MTK_PMIC_CHIP_MT6359),y)
subdir-ccflags-y += -Werror -I$(srctree)/drivers/misc/mediatek/pmic/include/mt6359
endif
ifeq ($(CONFIG_MTK_PMIC_NEW_ARCH),y)
subdir-ccflags-y += -Werror -I$(srctree)/drivers/misc/mediatek/pmic/include
endif
subdir-ccflags-y += -I$(srctree)/drivers/mmc/core
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/eccci/$(MTK_PLATFORM)
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/eccci/
subdir-ccflags-y += -I$(srctree)/drivers/clk/mediatek/
subdir-ccflags-y += -I$(srctree)/drivers/pinctrl/mediatek/
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/power_throttling/

# Do Nothing, move to standalone repo
MODULE_NAME := connadp
obj-y += $(MODULE_NAME).o
$(MODULE_NAME)-objs += common/connectivity_build_in_adapter.o
$(MODULE_NAME)-objs += common/wmt_build_in_adapter.o
$(MODULE_NAME)-objs += power_throttling/adapter.o
$(MODULE_NAME)-objs += power_throttling/core.o
$(MODULE_NAME)-objs += power_throttling/test.o

$(info $$CONFIG_MTK_COMBO_CHIP is [${CONFIG_MTK_COMBO_CHIP}])
MTK_PLATFORM_ID := $(patsubst CONSYS_%,%,$(subst ",,$(CONFIG_MTK_COMBO_CHIP)))
$(info MTK_PLATFORM_ID is [${MTK_PLATFORM_ID}])

ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6877"))
export MTK_COMBO_CHIP=CONNAC2X2_SOC5_0
export CONNAC_VER=2_0
else ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6885" "CONSYS_6893"))
export MTK_COMBO_CHIP=CONNAC2X2_SOC3_0
export CONNAC_VER=2_0
else ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6833"))
export MTK_COMBO_CHIP=SOC2_1X1
export CONNAC_VER=1_0
else ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6779" "CONSYS_6873" "CONSYS_6853"))
export MTK_COMBO_CHIP=SOC2_2X2
export CONNAC_VER=1_0
else
export MTK_COMBO_CHIP=CONNAC
export CONNAC_VER=1_0
export BT_PLATFORM=connac1x
endif

export MTK_PLATFORM_WMT=$(MTK_PLATFORM)
export TARGET_BOARD_PLATFORM_WMT=$(patsubst CONSYS_%,mt%,$(subst ",,$(CONFIG_MTK_COMBO_CHIP)))

# for gen4m options
export CONFIG_MTK_COMBO_WIFI_HIF=axi
export WLAN_CHIP_ID=$(MTK_PLATFORM_ID)
export MTK_ANDROID_WMT=y
export MTK_ANDROID_EMI=y

WLAN_IP_SET_1_SERIES := 6765 6761 6885 6893
WLAN_IP_SET_2_SERIES := 3967 6785
WLAN_IP_SET_3_SERIES := 6779 6873 6853

ifneq ($(filter $(WLAN_IP_SET_3_SERIES), $(WLAN_CHIP_ID)),)
$(info WIFI_IP_SET is 3)
export WIFI_IP_SET=3
else ifneq ($(filter $(WLAN_IP_SET_2_SERIES), $(WLAN_CHIP_ID)),)
$(info WIFI_IP_SET is 2)
export WIFI_IP_SET=2
else
$(info WIFI_IP_SET is 1)
export WIFI_IP_SET=1
endif

obj-y += common/
obj-y += wlan/core/gen4m/
obj-y += wlan/adaptor/
obj-y += bt/mt66xx/wmt/

ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6885" "CONSYS_6893" "CONSYS_6877"))
export CFG_BUILD_CONNAC2=true
else
export CFG_BUILD_CONNAC2=false
endif

FM_6631_CHIPS := 6758 6759 6771 6775 6765 6761 3967 6797 6768 6785 8168
FM_6635_CHIPS := 6779 6885 6873 6893 6877
ifneq ($(filter $(FM_6631_CHIPS), $(MTK_PLATFORM_ID)),)
 FM_CHIP := mt6631
else ifneq ($(filter $(FM_6635_CHIPS), $(MTK_PLATFORM_ID)),)
 FM_CHIP := mt6635
endif

export CFG_FM_CHIP_ID=$(MTK_PLATFORM_ID)
export CFG_FM_CHIP=$(FM_CHIP)
obj-y += fmradio/
obj-y += gps/