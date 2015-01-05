ARCHS = armv7 armv7s

include theos/makefiles/common.mk

TWEAK_NAME = AlarmStopper
AlarmStopper_FILES = Tweak.xm RIButtonItem.m UIAlertView+Blocks.m
AlarmStopper_FRAMEWORKS = UIKit Foundation


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
