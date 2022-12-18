import 'dart:ui';

import 'package:android_gesture_exclusion_platform_interface/method_channel_android_gesture_exclusion.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AndroidGestureExclusionPlatform extends PlatformInterface {
  AndroidGestureExclusionPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidGestureExclusionPlatform _instance =
      MethodChannelAndroidGestureExclusionPlatformInterface();

  static AndroidGestureExclusionPlatform get instance => _instance;

  static set instance(AndroidGestureExclusionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setSystemGestureExclusionRects(List<Rect> rects) {
    throw UnimplementedError(
      'setSystemGestureExclusionRects has not been implemented.',
    );
  }
}
