###############################################################################
# Bluetooth character device driver

###############################################################################
# Necessary Check

# Force build fail on modpost warning
KBUILD_MODPOST_FAIL_ON_WARNINGS := y

# platform
ccflags-y += -D CONNAC1X_CHIPID=$(BT_PLATFORM)

###############################################################################
# To add WMT dependent Macro and header file, will be removed later
$(info $(LOG_TAG) BT_ENABLE_LOW_POWER_DEBUG=$(BT_ENABLE_LOW_POWER_DEBUG))
ifeq ($(BT_ENABLE_LOW_POWER_DEBUG),y)
    ccflags-y += -D ENABLE_LOW_POWER_DEBUG=1
else
    ccflags-y += -D ENABLE_LOW_POWER_DEBUG=0
endif

ccflags-y += -D MTK_WCN_WMT_STP_EXP_SYMBOL_ABSTRACT
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat

ifeq ($(CONFIG_MTK_CONN_LTE_IDC_SUPPORT),y)
    ccflags-y += -D WMT_IDC_SUPPORT=1
else
    ccflags-y += -D WMT_IDC_SUPPORT=0
endif

###############################################################################
# To include BT driver dependent header file

WMT_SRC_FOLDER := $(TOP)/common
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/include
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/linux/include
ccflags-y += -I$(src)/../include/btif

###############################################################################

MODULE_NAME := bt_drv
obj-y += $(MODULE_NAME).o

ccflags-y += -D CREATE_NODE_DYNAMIC=1

$(MODULE_NAME)-objs += stp_chrdev_bt.o btmtk_dbg.o