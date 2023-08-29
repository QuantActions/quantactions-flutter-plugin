package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.google.gson.reflect.TypeToken
import com.google.gson.Gson
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.QAResponse
import com.quantactions.sdk.data.entity.JournalEvent
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class JournalStreamHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    private val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    private val listMapType = object : TypeToken<List<Map<String, Any>>>() {}.type
    private val ListIntType = object : TypeToken<List<Int>>() {}.type

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {
                "createJournalEntry" -> {
                    withContext(Dispatchers.IO) {
                        createJournalEntry(params)
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "deleteJournalEntry" -> {
                    withContext(Dispatchers.IO) {
                        deleteJournalEntry(params)
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "sendNote" -> {
                    withContext(Dispatchers.IO) {
                        sendNote(params)
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "getJournal" -> {
                    withContext(Dispatchers.IO) {
                        qa.getJournal()
                    }.collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeJournalEntryWithEvents(it)
                        )
                    }
                }

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

    private suspend fun createJournalEntry(params: Map<*, *>): Flow<QAResponse<String>> {
        val date = params["date"] as String

        val localDate = LocalDate.parse(date.substring(0, 10), formatter)
        val note = params["note"] as String

        val listMap: List<Map<String, Any>> = Gson().fromJson(
            params["events"] as String, listMapType
        )
        val eventList: List<JournalEvent> = listMap.map { map ->
            val id = map["id"] as String
            val publicName = map["publicName"] as String
            val iconName = map["iconName"] as String
            val created = map["created"] as String
            val modified = map["modified"] as String

            JournalEvent(id, publicName, iconName, created, modified)
        }

        val ratings: List<Int> = Gson().fromJson(
            params["ratings"] as String, ListIntType
        )

        val oldId = params["oldId"] as String

        return qa.createJournalEntry(
            localDate,
            note,
            eventList,
            ratings,
            oldId,
        )
    }

    private suspend fun deleteJournalEntry(params: Map<*, *>): Flow<QAResponse<String>> {
        val id = params["id"] as String

        return qa.deleteJournalEntry(id)
    }

    private suspend fun sendNote(params: Map<*, *>): Flow<QAResponse<String>> {
        val text = params["text"] as String

        return qa.sendNote(text)
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}