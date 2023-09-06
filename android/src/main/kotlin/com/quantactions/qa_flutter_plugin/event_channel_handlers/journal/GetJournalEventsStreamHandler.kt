package com.quantactions.qa_flutter_plugin.event_channel_handlers.journal

import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.data.entity.JournalEvent
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class GetJournalEventsStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {

                "getJournalEvents" -> {
                    withContext(Dispatchers.IO) {
                        qa.getJournalEvents()
                    }.collect {
                        val list = listOf(
                            JournalEvent(
                                "id",
                                "public_name",
                                "icon_name",
                                "created",
                                "modified"
                            ),
                            JournalEvent(
                                "id",
                                "public_name",
                                "icon_name",
                                "created",
                                "modified"
                            ),
                        )

                        eventSink.success(QAFlutterPluginSerializable.serializeJournalEvents(list))
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}