package com.quantactions.qa_flutter_plugin.event_channel_handlers.journal

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class GetJournalEventKindsStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/get_journal_event_kinds"
        )
        channel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as Map<*, *>

            when (params["method"]) {
                "journalEventKinds" -> {
                    QAFlutterPluginHelper.safeEventChannel(
                        eventSink = eventSink,
                        methodName = "journalEventKinds",
                        method = {
                            val response = qa.journalEventKinds()

                            eventSink.success(
                                QAFlutterPluginSerializable.serializeJournalEventEntity(
                                    response
                                )
                            )
                        },
                    )
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}