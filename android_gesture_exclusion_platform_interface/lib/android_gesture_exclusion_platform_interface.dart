import 'dart:ui';

import 'package:android_gesture_exclusion_platform_interface/method_channel_android_gesture_exclusion.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface each platform implementation must implement.
abstract class AndroidGestureExclusionPlatform extends PlatformInterface {
  /// Constructs an AndroidGestureExclusionPlatform.
  AndroidGestureExclusionPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidGestureExclusionPlatform _instance =
      MethodChannelAndroidGestureExclusionPlatformInterface();

  /// The default instance of [AndroidGestureExclusionPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidGestureExclusionPlatformInterface].
  static AndroidGestureExclusionPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [AndroidGestureExclusionPlatform] when they register themselves.
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
