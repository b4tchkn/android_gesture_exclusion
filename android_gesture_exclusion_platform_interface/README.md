# android_gesture_exclusion_platform_interface

A common platform interface for the [`android_gesture_exclusion`][1]
plugin.

This interface allows platform-specific implementations of the android_gesture_exclusion plugin, as
well as the plugin itself, to ensure they are supporting the same interface.

## Usage

To implement a new platform-specific implementation of `android_gesture_exclusion`,
extend [`AndroidGestureExclusionPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the
default `AndroidGestureExclusionPlatform` by calling
`AndroidGestureExclusionPlatform.instance = MyAndroidGestureExclusionPlatform()`.

## Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface)
over breaking changes for this package.

See https://flutter.dev/go/platform-interface-breaking-changes for a discussion on why a less-clean
interface is preferable to a breaking change.

## Issues

Please file any issues, bugs or feature request as an issue on
our [GitHub](https://github.com/b4tchkn/android_gesture_exclusion/issues) page.

[1]: ../android_gesture_exclusion

[2]: lib/android_gesture_exclusion_platform_interface.dart
