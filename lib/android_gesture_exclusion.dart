
import 'android_gesture_exclusion_platform_interface.dart';

class AndroidGestureExclusion {
  Future<String?> getPlatformVersion() {
    return AndroidGestureExclusionPlatform.instance.getPlatformVersion();
  }
}
