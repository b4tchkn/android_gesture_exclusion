package com.github.b4tchkn.android_gesture_exclusion

import android.app.Activity
import android.graphics.Rect
import androidx.core.view.ViewCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class AndroidGestureExclusionPlugin : FlutterPlugin, ActivityAware {
    private var methodChannel: MethodChannel? = null;

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "com.github.b4tchkn/android_gesture_exclusion"
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodChannel?.setMethodCallHandler(AndroidGestureExclusionMethodHandler(binding.activity))
    }

    override fun onDetachedFromActivityForConfigChanges() {
        methodChannel?.setMethodCallHandler(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        methodChannel?.setMethodCallHandler(AndroidGestureExclusionMethodHandler(binding.activity))
    }

    override fun onDetachedFromActivity() {
        methodChannel?.setMethodCallHandler(null)
    }
}

private class AndroidGestureExclusionMethodHandler(private val activity: Activity) :
    MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setSystemGestureExclusionRects" -> {
                val arguments = call.arguments as List<Map<String, Int>>
                val decodedRects = decodeExclusionRects(arguments)
                ViewCompat.setSystemGestureExclusionRects(activity.window.decorView, decodedRects)
                result.success(null)
            }
        }
    }

    private fun decodeExclusionRects(inputRects: List<Map<String, Int>>): List<Rect> =
        inputRects.mapIndexed { index, item ->
            Rect(
                item["left"] ?: error("rect at index $index doesn't contain 'left' property"),
                item["top"] ?: error("rect at index $index doesn't contain 'top' property"),
                item["right"] ?: error("rect at index $index doesn't contain 'right' property"),
                item["bottom"] ?: error("rect at index $index doesn't contain 'bottom' property")
            )
        }
}
