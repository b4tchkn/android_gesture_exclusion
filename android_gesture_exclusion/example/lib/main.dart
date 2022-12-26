import 'dart:async';

import 'package:android_gesture_exclusion/android_gesture_exclusion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey sliderKey = GlobalKey();
  double _position = 1.0;
  double _position2 = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlatformState());
  }

  Future<void> initPlatformState() async {
    final androidGestureExclusion = AndroidGestureExclusion.instance;
    if (!mounted) return;

    final context = sliderKey.currentContext;

    if (context == null) {
      debugPrint("Slider is not in hierarchy yet");
      return;
    }

    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    final ratio = MediaQuery.of(context).devicePixelRatio;
    final verticalThreshold = 10 * ratio;

    final left = position.dx * ratio;
    final top = position.dy * ratio;
    final right = left + box.size.width * ratio;
    final bottom = top + box.size.height * ratio;
    final rect = Rect.fromLTRB(
        left, top - verticalThreshold, right, bottom + verticalThreshold);

    try {
      androidGestureExclusion.setRects([rect]);
    } on PlatformException {
      debugPrint('AndroidGestureExclusion Platform Exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('android_gesture_exclusion example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_position.toString()),
              Slider(
                key: sliderKey,
                value: _position,
                onChanged: (newPosition) {
                  setState(() {
                    _position = newPosition;
                  });
                },
              ),
              Text(_position2.toString()),
              AndroidGestureExclusionContainer(
                verticalExclusionMargin: 20,
                child: Slider(
                  value: _position2,
                  onChanged: (newPosition) {
                    setState(() {
                      _position2 = newPosition;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
