package com.quantactions.qa_flutter_plugin.method_channel_handlers.permission

import android.content.Context
import android.app.Activity
import android.content.ContextWrapper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class RequestUsagePermissionMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context,
    private var activityAccessor: () -> Activity
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/request_usage_permission")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            val activity = activityAccessor();
            if (call.method == "requestUsagePermission") {
                QAFlutterPluginHelper.safeMethodChannel(
                    result = result,
                    methodName = "requestUsagePermission",
                    method = { result.success(qa.requestUsagePermission(activity)) }
                )
            } else {
                throw UnsupportedOperationException()
            }
        }
    }
}