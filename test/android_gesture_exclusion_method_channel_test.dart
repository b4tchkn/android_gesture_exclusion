import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_gesture_exclusion/android_gesture_exclusion_method_channel.dart';

void main() {
  MethodChannelAndroidGestureExclusion platform = MethodChannelAndroidGestureExclusion();
  const MethodChannel channel = MethodChannel('android_gesture_exclusion');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
