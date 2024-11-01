package com.quantactions.qa_flutter_plugin.event_channel_handlers

import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class GetJournalEntriesStreamHandler(
    private var ioScope: CoroutineScope,
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var mainEventSink: EventChannel.EventSink? = null
    private var job: Job? = null

    fun destroy() {
        mainEventSink = null
        job?.cancel()
    }

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding): GetJournalEntriesStreamHandler {
        val channel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin_stream/get_journal_entries"
        )
        channel.setStreamHandler(this)
        return this
    }


    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        mainEventSink = eventSink

        job = ioScope.launch {
            qa.journalEntries().collect{
                mainScope.launch {
                    mainEventSink?.success(
                        QAFlutterPluginSerializable.serializeJournalEntryList(
                            it
                        )
                    )
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        mainEventSink = null
        job?.cancel()
    }
}