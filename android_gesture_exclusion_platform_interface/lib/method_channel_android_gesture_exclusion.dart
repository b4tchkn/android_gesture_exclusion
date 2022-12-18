import 'package:android_gesture_exclusion_platform_interface/android_gesture_exclusion_platform_interface.dart';
import 'package:flutter/services.dart';

class MethodChannelAndroidGestureExclusionPlatformInterface
    extends AndroidGestureExclusionPlatform {
  final methodChannel = const MethodChannel(
    'com.github.b4tchkn/android_gesture_exclusion',
  );

  @override
  Future<void> setSystemGestureExclusionRects(List<Rect> rects) async {
    final rectsAsMaps = rects
        .map(
          (r) => r.hasNaN || r.isInfinite
              ? null
              : {
                  'left': r.left.floor(),
                  'top': r.top.floor(),
                  'right': r.right.floor(),
                  'bottom': r.bottom.floor(),
                },
        )
        .toList();
    await methodChannel.invokeMethod<void>(
      'setSystemGestureExclusionRects',
      rectsAsMaps,
    );
  }
}
