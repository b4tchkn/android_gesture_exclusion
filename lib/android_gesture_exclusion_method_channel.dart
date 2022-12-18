import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_gesture_exclusion_platform_interface.dart';

/// An implementation of [AndroidGestureExclusionPlatform] that uses method channels.
class MethodChannelAndroidGestureExclusion extends AndroidGestureExclusionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_gesture_exclusion');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
