import 'dart:io';

import 'package:android_gesture_exclusion_platform_interface/android_gesture_exclusion_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AndroidGestureExclusion {
  AndroidGestureExclusion._();

  static final instance = AndroidGestureExclusion._();

  static AndroidGestureExclusionPlatform get _platform =>
      AndroidGestureExclusionPlatform.instance;

  void setRects(List<Rect> rects) =>
      _platform.setSystemGestureExclusionRects(rects);

  void clear() => _platform.setSystemGestureExclusionRects([]);
}

class AndroidGestureExclusionContainer extends StatefulWidget {
  const AndroidGestureExclusionContainer({
    Key? key,
    this.verticalExclusionMargin = 0,
    this.horizontalExclusionMargin = 0,
    required this.child,
  }) : super(key: key);

  final double verticalExclusionMargin;
  final double horizontalExclusionMargin;
  final Widget child;

  @override
  State<AndroidGestureExclusionContainer> createState() =>
      _AndroidGestureExclusionContainerState();
}

class _AndroidGestureExclusionContainerState
    extends State<AndroidGestureExclusionContainer> {
  final _visibilityKey = UniqueKey();
  final _exclusionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) return widget.child;

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0) {
          AndroidGestureExclusion.instance.clear();
        } else {
          final currentContext = _exclusionKey.currentContext;
          final renderBox = currentContext?.findRenderObject() as RenderBox?;
          final rect = _rectWithMargin(
            renderBox?.localToGlobal(Offset.zero) ?? Offset.zero,
            renderBox?.size ?? Size.zero,
            MediaQuery.of(context).devicePixelRatio,
            widget.horizontalExclusionMargin,
            widget.verticalExclusionMargin,
          );
          AndroidGestureExclusion.instance.setRects([rect]);
        }
      },
      child: _GestureExclusion(
        key: _exclusionKey,
        verticalExclusionMargin: widget.verticalExclusionMargin,
        horizontalExclusionMargin: widget.horizontalExclusionMargin,
        child: widget.child,
      ),
    );
  }
}

class _GestureExclusion extends SingleChildRenderObjectWidget {
  const _GestureExclusion({
    Key? key,
    required this.verticalExclusionMargin,
    required this.horizontalExclusionMargin,
    required Widget child,
  }) : super(key: key, child: child);

  final double verticalExclusionMargin;
  final double horizontalExclusionMargin;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderGestureExclusion(
      verticalExclusionMargin: verticalExclusionMargin,
      horizontalExclusionMargin: horizontalExclusionMargin,
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderGestureExclusion renderObject,
  ) {
    renderObject
      ..devicePixelRatio = MediaQuery.of(context).devicePixelRatio
      ..verticalExclusionMargin = verticalExclusionMargin
      ..horizontalExclusionMargin = horizontalExclusionMargin;
  }

  @override
  void didUnmountRenderObject(covariant RenderObject renderObject) {
    AndroidGestureExclusion.instance.clear();
  }
}

class _RenderGestureExclusion extends RenderProxyBox {
  _RenderGestureExclusion({
    required this.verticalExclusionMargin,
    required this.horizontalExclusionMargin,
    required this.devicePixelRatio,
  });

  double verticalExclusionMargin;
  double horizontalExclusionMargin;
  double devicePixelRatio;

  @override
  void performLayout() {
    super.performLayout();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final position = localToGlobal(Offset.zero);
      final rect = _rectWithMargin(
        position,
        size,
        devicePixelRatio,
        horizontalExclusionMargin,
        verticalExclusionMargin,
      );
      AndroidGestureExclusion.instance.setRects([rect]);
    });
  }
}

Rect _rectWithMargin(
  Offset globalPosition,
  Size size,
  double devicePixelRatio,
  double horizontalMargin,
  double verticalMargin,
) {
  final left = globalPosition.dx * devicePixelRatio;
  final top = globalPosition.dy * devicePixelRatio;
  final right = left + size.width * devicePixelRatio;
  final bottom = top + size.height * devicePixelRatio;
  return Rect.fromLTRB(
    left - horizontalMargin,
    top - verticalMargin,
    right + horizontalMargin,
    bottom + verticalMargin,
  );
}
