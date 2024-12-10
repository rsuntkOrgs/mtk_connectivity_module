MTK_PLATFORM := $(subst ",,$(CONFIG_MTK_PLATFORM))
###############################################################################
# Bluetooth character device driver

###############################################################################
# Necessary Check
ifneq ($(CFG_BT_PM_QOS_CONTROL),)
    $(warning set PM_QOS_CONTROL=1)
    ccflags-y += -D PM_QOS_CONTROL=1
else
    ccflags-y += -D PM_QOS_CONTROL=0
endif

# Force build fail on modpost warning
KBUILD_MODPOST_FAIL_ON_WARNINGS := y
###############################################################################
# To add WMT dependent Macro and header file, will be removed later

ccflags-y += -D MTK_WCN_WMT_STP_EXP_SYMBOL_ABSTRACT
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/$(MTK_PLATFORM)/include

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

###############################################################################

MODULE_NAME := bt_drv
obj-y += $(MODULE_NAME).o

ccflags-y += -D CREATE_NODE_DYNAMIC=1

$(MODULE_NAME)-objs += stp_chrdev_bt.o dbg_bt.o