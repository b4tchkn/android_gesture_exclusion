import 'package:flutter_test/flutter_test.dart';
import 'package:android_gesture_exclusion/android_gesture_exclusion.dart';
import 'package:android_gesture_exclusion/android_gesture_exclusion_platform_interface.dart';
import 'package:android_gesture_exclusion/android_gesture_exclusion_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidGestureExclusionPlatform
    with MockPlatformInterfaceMixin
    implements AndroidGestureExclusionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AndroidGestureExclusionPlatform initialPlatform = AndroidGestureExclusionPlatform.instance;

  test('$MethodChannelAndroidGestureExclusion is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidGestureExclusion>());
  });

  test('getPlatformVersion', () async {
    AndroidGestureExclusion androidGestureExclusionPlugin = AndroidGestureExclusion();
    MockAndroidGestureExclusionPlatform fakePlatform = MockAndroidGestureExclusionPlatform();
    AndroidGestureExclusionPlatform.instance = fakePlatform;

    expect(await androidGestureExclusionPlugin.getPlatformVersion(), '42');
  });
}
