package com.quantactions.qa_flutter_plugin.method_channel_handlers.permission

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class CanDrawMethodChannelHandler(
    private var mainScope: CoroutineScope, private var qa: QA, private var context: Context
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/can_draw")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "canDraw" -> {
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "canDraw",
                        method = { result.success(qa.canDraw(context)) }
                    )
                }
            }
        }
    }
}