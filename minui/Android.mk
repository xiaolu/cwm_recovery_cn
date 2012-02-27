LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := events.c resources.c
ifneq ($(BOARD_CUSTOM_GRAPHICS),)
  LOCAL_SRC_FILES += $(BOARD_CUSTOM_GRAPHICS)
else
ifeq ($(RECOVERY_USE_CHINESE_FONT), true)
  LOCAL_SRC_FILES += graphics_cn.c
else
  LOCAL_SRC_FILES += graphics.c
endif
endif

LOCAL_C_INCLUDES +=\
    external/libpng\
    external/zlib

ifneq ($(BOARD_LDPI_RECOVERY),)
    LOCAL_CFLAGS += -DBOARD_LDPI_RECOVERY='"$(BOARD_LDPI_RECOVERY)"'
endif

ifneq ($(BOARD_HAS_JANKY_BACKBUFFER),)
    LOCAL_CFLAGS += -DBOARD_HAS_JANKY_BACKBUFFER
endif

ifeq ($(BOARD_HAS_FLIPPED_SCREEN), true)
    LOCAL_CFLAGS += -DBOARD_HAS_FLIPPED_SCREEN
endif

ifeq ($(BOARD_USE_GR_FLIP_32), true)
    LOCAL_CFLAGS += -DBOARD_USE_GR_FLIP_32
endif

LOCAL_MODULE := libminui

include $(BUILD_STATIC_LIBRARY)
