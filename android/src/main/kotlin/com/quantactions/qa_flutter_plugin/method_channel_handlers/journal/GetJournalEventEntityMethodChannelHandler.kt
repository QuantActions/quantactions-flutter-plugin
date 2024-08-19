package com.quantactions.qa_flutter_plugin.method_channel_handlers.journal

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch

class GetJournalEventEntityMethodChannelHandler(
    private var ioScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/get_journal_event_kinds"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        ioScope.launch {
            when (call.method) {
                "journalEventKinds" -> {
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "journalEventKinds",
                        method = {
                            async {
                                result.success(
                                    QAFlutterPluginSerializable.serializeJournalEventEntity(
                                        qa.journalEventKinds()
                                    )
                                )
                            }.await()
                        }
                    )
                }
            }
        }
    }
}