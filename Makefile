TWEAK_NAME = NowNow
NowNow_FILES = Tweak.xm
NowNow_FRAMEWORKS = UIKit
TARGET = iphone:7.0:5.0
ARCHS = armv7 arm64

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
