package com.quantactions.qa_flutter_plugin.method_channel_handlers.device

import android.content.Context
import android.content.Intent
import android.provider.Settings;
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import android.net.Uri
import kotlinx.coroutines.launch

class OpenBatteryOptimisationSettingsChannelHandler (
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/open_battery_optimisation_settings"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "retrieveBatteryOptimizationIntentForCurrentManufacturer" -> QAFlutterPluginHelper.safeMethodChannel(
                    result = result,
                    methodName = "retrieveBatteryOptimizationIntentForCurrentManufacturer",
                    method = {
                        val intent = qa.retrieveBatteryOptimizationIntentForCurrentManufacturer(context)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        result.success(context.startActivity(intent))
                    }
                )
            }
        }
    }
}