package com.quantactions.qa_flutter_plugin.event_channel_handlers.journal

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class GetJournalStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {

                "getJournal" -> {
                    withContext(Dispatchers.IO) {
                        qa.getJournal()
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeJournalEntryWithEvents(it)
                        )
                    }
                }

                "getJournalSample" -> {
                    withContext(Dispatchers.IO) {
                        val apiKey = params["apiKey"] as String

                        qa.getJournalSample(context, apiKey)
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeJournalEntryWithEvents(it)
                        )
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}