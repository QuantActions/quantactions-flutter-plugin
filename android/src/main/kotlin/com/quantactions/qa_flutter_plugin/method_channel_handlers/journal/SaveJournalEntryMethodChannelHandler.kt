package com.quantactions.qa_flutter_plugin.method_channel_handlers.journal

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.data.model.JournalEntry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class SaveJournalEntryMethodChannelHandler(
    private var ioScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/save_journal_entry"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        ioScope.launch {
            when (call.method) {
                "saveJournalEntry" -> {
                    val params = call.arguments as Map<*, *>

                    val id = params["id"] as String?
                    val date = params["date"] as String?
                    val note = params["note"] as String?
                    val events = params["events"] as String?

                    if (date != null && note != null && events != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "saveJournalEntry",
                            method = {
                                val formatter =
                                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                val dateTime = LocalDateTime.parse(date, formatter)
                                val localDate = dateTime.toLocalDate()

                                val journalEvents = QAFlutterPluginSerializable
                                    .serializeJournalEventFromJson(events)

                                val journalEntry = JournalEntry(
                                    id, localDate, note, journalEvents.toMutableList()
                                )

                                async {
                                    result.success(
                                        QAFlutterPluginSerializable.serializeJournalEntry(
                                            qa.saveJournalEntry(journalEntry)
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
}