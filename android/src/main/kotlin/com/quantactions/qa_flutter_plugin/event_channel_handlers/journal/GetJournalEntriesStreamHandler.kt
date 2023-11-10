package com.quantactions.qa_flutter_plugin.event_channel_handlers.journal

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class GetJournalEntriesStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/get_journal_entries"
        )
        channel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as Map<*, *>

            when (params["method"]) {

                "journalEntries" -> {
                    QAFlutterPluginHelper.safeEventChannel(
                        eventSink = eventSink,
                        methodName = "journalEntries",
                        method = {
                            qa.journalEntries().collect {
                                eventSink.success(
                                    QAFlutterPluginSerializable.serializeJournalEntryList(
                                        it
                                    )
                                )
                            }

                        },
                    )
                }

                "journalEntriesSample" -> {
                    withContext(Dispatchers.IO) {
                        val apiKey = params["apiKey"] as String?

                        if (apiKey != null) {
                            QAFlutterPluginHelper.safeEventChannel(
                                eventSink = eventSink,
                                methodName = "journalEntriesSample",
                                method = {
                                    val response = qa.getJournalSample(context, apiKey)

                                    eventSink.success(
                                        QAFlutterPluginSerializable.serializeJournalEntryList(
                                            response
                                        )
                                    )
                                },
                            )
                        } else {
                            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                                eventSink = eventSink, methodName = "journalEntriesSample"
                            )
                        }
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}