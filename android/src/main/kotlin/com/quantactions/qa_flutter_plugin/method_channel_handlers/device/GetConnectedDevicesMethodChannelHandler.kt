package com.quantactions.qa_flutter_plugin.method_channel_handlers.device

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.async

class GetConnectedDevicesMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/get_connected_devices")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "getConnectedDevices" -> {
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "getConnectedDevices",
                        method = { async {
                            result.success(QAFlutterPluginSerializable.serializeDevicesIds(qa.getConnectedDevices()))
                        }.await() }
                    )
                }
            }
        }
    }
}

// QAFlutterPluginSerializable.serializeDevicesIds