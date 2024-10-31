package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class GetJournalEntriesStreamHandler(
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun destroy() {
        eventSink = null
    }

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding): GetJournalEntriesStreamHandler {
        val channel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin_stream/get_journal_entries"
        )
        channel.setStreamHandler(this)
        return this
    }

    suspend fun getJournalEntries() {
        val flow = qa.journalEntries()
        val first = flow.first()
            eventSink?.success(
                QAFlutterPluginSerializable.serializeJournalEntryList(
                    first
                )
            )
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        ioScope.launch {
            getJournalEntries()
        }

//        ioScope.launch {
//            val params = arguments as Map<*, *>
//
//            when (params["method"]) {
//
//                "journalEntries" -> {
//                    QAFlutterPluginHelper.safeEventChannel(
//                        eventSink = eventSink,
//                        methodName = "journalEntries",
//                        method = {
//                                val flow = qa.journalEntries()
//
//                            val a = flow.first()
//                                    eventSink.success(
//                                        QAFlutterPluginSerializable.serializeJournalEntryList(
//                                            a
//                                        )
//                                    )
//
//                        },
//                    )
//                }
//            }
//        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}