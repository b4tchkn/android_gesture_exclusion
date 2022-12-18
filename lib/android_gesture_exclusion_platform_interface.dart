import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_gesture_exclusion_method_channel.dart';

abstract class AndroidGestureExclusionPlatform extends PlatformInterface {
  /// Constructs a AndroidGestureExclusionPlatform.
  AndroidGestureExclusionPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidGestureExclusionPlatform _instance = MethodChannelAndroidGestureExclusion();

  /// The default instance of [AndroidGestureExclusionPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidGestureExclusion].
  static AndroidGestureExclusionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidGestureExclusionPlatform] when
  /// they register themselves.
  static set instance(AndroidGestureExclusionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
