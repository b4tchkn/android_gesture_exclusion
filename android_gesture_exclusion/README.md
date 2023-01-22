# android_gesture_exclusion

This plugin wraps
the
Android's [View#getSystemGestureExclusionRects()](https://developer.android.com/reference/android/view/View#getSystemGestureExclusionRects())
API to avoid conflict between Gesture Navigation supported in Android 10 (API level 29) and later
and the existing UI swipe gestures from either the left or the right edge of the screen. This plugin
works only on Android.

## How to use

### Using instance

```dart
// Set GlobalKey to get the Rect of the Widget.
final GlobalKey globalKey = GlobalKey();

@override
Widget build(BuildContext context) {
  return SampleWidget(
    key: globalKey,
  );
}
```

```dart
// You can get the Rect of the Widget to set from GlobalKey.
final context = sliderKey.currentContext;
final box = context.findRenderObject() as RenderBox;
final position = box.localToGlobal(Offset.zero);

final ratio = MediaQuery
    .of(context)
    .devicePixelRatio;
final left = position.dx * ratio;
final top = position.dy * ratio;
final right = left + box.size.width * ratio;
final bottom = top + box.size.height * ratio;
final rect = Rect.fromLTRB(left, top, right, bottom);

// You can create instance and set some rects wants to exclude gesture navigation.
final androidGestureExclusion = AndroidGestureExclusion.instance;
androidGestureExclusion.setRects
([rect
]
);
```

### Using Widget

```dart
@override
Widget build(BuildContext context) {
  // Simply wrap the Widget in the area you wish to exclude GestureNavigation.
  // You can also set horizontal and vertical margins.
  return AndroidGestureExclusionContainer(
    verticalExclusionMargin: 20,
    child: SampleWidget(),
  );
}
```

## Issues

Please file any issues, bugs or feature request as an issue on
our [GitHub](https://github.com/b4tchkn/android_gesture_exclusion/issues) page. 