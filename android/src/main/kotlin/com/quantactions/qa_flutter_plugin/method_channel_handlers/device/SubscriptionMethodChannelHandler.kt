package com.quantactions.qa_flutter_plugin.method_channel_handlers.device

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.Subscription
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import java.time.LocalDate

class SubscriptionMethodChannelHandler(
    private var mainScope: CoroutineScope,
//    private var ioScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/subscription")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "subscription" -> {
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "subscription",
                        method = {
                            runBlocking {
                                val response = qa.subscription()

                                if (response == null) {
                                    result.success(null)
                                } else {
                                    result.success(
                                        QAFlutterPluginSerializable.serializeSubscription(
                                            response
                                        )
                                    )
                                }
                            }
                        },
                    )
                }

                "getJournalEntry" -> {
                    val params = call.arguments as Map<*, *>

                    val journalEntryId = params["journalEntryId"] as String?

                    if (journalEntryId != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "getJournalEntry",
                            method = {
                                val response = qa.getJournalEntry(journalEntryId)

                                result.success(
                                    if (response == null) null
                                    else QAFlutterPluginSerializable.serializeJournalEntry(response)
                                )
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result,
                            methodName = "getJournalEntry"
                        )
                    }
                }
            }
        }
    }
}