# inherit from the proprietary version
-include vendor/lge/p970/BoardConfigVendor.mk

## Board configuration
TARGET_ARCH := arm
TARGET_BOARD_PLATFORM := omap3
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a8
TARGET_CPU_VARIANT := cortex-a8
TARGET_ARCH_VARIANT_FPU := neon
TARGET_ARCH_LOWMEM := true
# ARCH_ARM_HAVE_TLS_REGISTER := true
OMAP_ENHANCEMENT := true

TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_arm_CFLAGS := -O3 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops \
                       -fmodulo-sched -fmodulo-sched-allow-regmoves
TARGET_thumb_CFLAGS := -mthumb \
                        -Os \
                        -fomit-frame-pointer \
                        -fstrict-aliasing

TARGET_BOOTLOADER_BOARD_NAME := p970

BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_PAGE_SIZE := 0x00000800

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 665681920
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1170259968
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_NEEDS_CUTILS_LOG := true

BOARD_HAS_NO_SELECT_BUTTON := true
# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true

## Kernel
TARGET_KERNEL_CONFIG := custom_p970_defconfig
TARGET_PREBUILT_KERNEL := device/lge/p970/kernel
TARGET_RECOVERY_INITRC := device/lge/p970/recovery/init-recovery.rc

## OMAP
ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC
endif

# BOARD_USES_TI_CAMERA_HAL := true
HARDWARE_OMX := true
ifdef HARDWARE_OMX
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
#BOARD_CAMERA_LIBRARIES := libcamera
endif

## Device
TARGET_SPECIFIC_HEADER_PATH := device/lge/p970/include
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/p970/vibrator.c
BOARD_SYSFS_LIGHT_SENSOR := "/sys/devices/platform/omap/omap_i2c.2/i2c-2/2-0060/leds/lcd-backlight/als"
COMMON_GLOBAL_CFLAGS += -DHAS_CONTEXT_PRIORITY -DDONT_USE_FENCE_SYNC
COMMON_GLOBAL_CFLAGS += -DBOARD_CHARGING_CMDLINE_NAME='"rs"' -DBOARD_CHARGING_CMDLINE_VALUE='"c"'
# COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS
BOARD_RIL_CLASS := ../../../device/lge/p970/ril/

## WLAN
#BOARD_MOBILEDATA_INTERFACE_NAME  := "vsnet0"
#BOARD_WLAN_DEVICE                := bcm4329
#WIFI_DRIVER_FW_PATH_STA          := "/system/etc/firmware/fw_bcm4329.bin"
#WIFI_DRIVER_FW_PATH_AP           := "/system/etc/firmware/fw_bcm4329_ap.bin"
#WIFI_DRIVER_MODULE_NAME          := "wireless"
#WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wireless.ko"
#WIFI_DRIVER_MODULE_ARG           := "firmware_path=/system/etc/firmware/fw_bcm4329.bin nvram_path=/system/etc/wifi/nvram.txt config_path=/data/misc/wifi/config"
#WPA_SUPPLICANT_VERSION           := VER_0_8_X
#BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wext
#BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
#WIFI_DRIVER_HAS_LGE_SOFTAP       := true
#BOARD_WPA_SUPPLICANT_DRIVER      := WEXT

## Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p970/bluetooth
BOARD_HAVE_FM_RADIO := true

## Recovery
DEVICE_RESOLUTION := 480x800
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/p970/recovery/graphics.c
TARGET_RECOVERY_FSTAB := device/lge/p970/configs/fstab.black
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# Disable SELinux
PRODUCT_PROPERTY_OVERRIDES += \
	ro.boot.selinux=disabled

# We indeed have pre KitKat blobs
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true

# Compatibility with pre-kitkat Sensor HALs
SENSORS_NEED_SETRATE_ON_ENABLE := true

# No, we dont want SET_METADATA -.-
SKIP_SET_METADATA := true

# LTO ?
BOARD_HARDWARE_CLASS := device/lge/p970/cmhw/

# EGL
BOARD_EGL_CFG := device/lge/p970/configs/egl.cfg
USE_OPENGL_RENDERER := true
ENABLE_WEBGL := true
COMMON_GLOBAL_CFLAGS += -DSYSTEMUI_PBSIZE_HACK=1
COMMON_GLOBAL_CFLAGS += -DWORKAROUND_BUG_10194508=1
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
TARGET_DISABLE_TRIPLE_BUFFERING := true
# BOARD_EGL_NEEDS_LEGACY_FB := true
# BOARD_EGL_NEEDS_FNW := true

# Fix Graphics Issues
PRODUCT_PROPERTY_OVERRIDES += \
	ro.zygote.disable_gl_preload=true \
	ro.bq.gpu_to_cpu_unsupported=true \
	dalvik.vm.debug.alloc=0 \
	ro.hwui.disable_scissor_opt=true

# Additional Props
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true  \
	dalvik.vm.jit.codecachesize=0
