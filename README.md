# android_gesture_exclusion

This plugin wraps the
Android's [View#getSystemGestureExclusionRects()](https://developer.android.com/reference/android/view/View#getSystemGestureExclusionRects())
API to avoid conflict between Gesture Navigation supported in Android 10 (API level 29) and later
and the existing UI swipe gestures from either the left or the right edge of the screen. This plugin
works only on Android.

[See here for details](https://developer.android.com/develop/ui/views/touch-and-input/gestures/gesturenav)
.

The android_gesture_exclusion plugin is separated into the following packages:

1. [`android_gesture_exclusion`][1]: the app facing package. This is the package users depend on to
   use the plugin in their project. For details on how to use the `android_gesture_exclusion` plugin
   you can refer to its [README.md][3] file.
2. [`android_gesture_exclusion_platform_interface`][2]: this packages declares the interface which
   all platform packages must implement to support the app-facing package. This plugin only works on
   the Android platform, but follows the [Flutter federated plugin concept][5]. Instructions on how
   to implement a platform packages can be found int the [README.md][4] of the
   `android_gesture_exclusion_platform_interface` package.

[1]: ./android_gesture_exclusion

[2]: ./android_gesture_exclusion_platform_interface

[3]: ./android_gesture_exclusion/README.md

[4]: ./android_gesture_exclusion_platform_interface/README.md

[5]: https://docs.flutter.dev/development/packages-and-plugins/developing-packages#federated-plugins