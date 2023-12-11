package com.quantactions.qa_flutter_plugin.method_channel_handlers.journal

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch

class GetJournalEntriesSampleMethodChannelHandler(
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/get_journal_entries_sample"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        ioScope.launch {
            when (call.method) {
                "journalEntriesSample" -> {
                    val params = call.arguments as Map<*, *>

                    val apiKey = params["apiKey"] as String?

                    if (apiKey != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "journalEntriesSample",
                            method = {
                                async {
                                    result.success(
                                        QAFlutterPluginSerializable.serializeJournalEntryList(
                                            qa.getJournalSample(context, apiKey)
                                        )
                                    )
                                }.await()
                            },
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result, methodName = "journalEntriesSample"
                        )
                    }
                }
            }
        }
    }
}