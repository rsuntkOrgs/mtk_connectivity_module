# Mediatek external kernel modules

> [!NOTE]
> Imported from `SM-A055F/Platform.tar.gz/vendor/mediatek/kernel_modules/connectivity`
>
> Supported platform: `MT6765` and `MT6768` (adding more platform support in the future)

> [!WARNING]
> This driver is intended only for 4.19.x. Not for 4.14.x or below.

# Mediatek required configurations
**Make sure to enable this in your device defconfig!**
```
CONFIG_MTK_COMBO_BT=y
CONFIG_MTK_COMBO_WIFI=y
CONFIG_MTK_COMBO_GPS=y
CONFIG_MTK_GPS_SUPPORT=y
CONFIG_MTK_FMRADIO=y
```

# Build configurations
```
CONFIG_DRV_BUILD_IN=y
```
# Bootloop issue
Bootloop can caused by insmod `/vendor/lib/modules/*.ko` conflicting with drivers inline. Remove `/vendor/lib/modules/*.ko` can solve it.