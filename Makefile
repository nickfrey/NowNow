include theos/makefiles/common.mk

TWEAK_NAME = NowNow
NowNow_FILES = Tweak.xm
NowNow_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
