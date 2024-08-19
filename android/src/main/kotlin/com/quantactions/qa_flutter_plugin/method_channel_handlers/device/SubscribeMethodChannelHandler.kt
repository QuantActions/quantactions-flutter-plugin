package com.quantactions.qa_flutter_plugin.method_channel_handlers.device

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch

class SubscribeMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/subscribe")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "subscribe" -> {
                    val params = call.arguments as Map<*, *>
                    val subscriptionIdOrCohortId = params["subscriptionIdOrCohortId"] as String?

                    if (subscriptionIdOrCohortId != null) {
                        QAFlutterPluginHelper.safeMethodChannel(result = result,
                            methodName = "subscribe",
                            method = {
                                async {
                                    result.success(
                                        QAFlutterPluginSerializable.serializeSubscriptionWithQuestionnaires(
                                            qa.subscribe(subscriptionIdOrCohortId)
                                        )
                                    )
                                }.await()
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result, methodName = "subscribe"
                        )
                    }
                }
            }
        }
    }
}