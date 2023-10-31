package com.quantactions.qa_flutter_plugin.method_channel_handlers.journal

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.BasicInfo
import com.quantactions.sdk.QA
import com.quantactions.sdk.QAResponse
import com.quantactions.sdk.data.model.JournalEntry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class SaveJournalEntryMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {

    private val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
//    private val listMapType = object : TypeToken<List<Map<String, Any>>>() {}.type
//    private val ListIntType = object : TypeToken<List<Int>>() {}.type

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        var channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/save_journal_entry"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "saveJournalEntry" -> {
                    //TODO: (Karatysh): uncomment and implement method when will be ready
//                    val id = params["id"] as String?
//
//                    val date = params["date"] as String
//                    val localDate = LocalDate.parse(date.substring(0, 10), formatter)
//
//                    val note = params["note"] as String
//
//                    val listMap: List<Map<String, Any>> = Gson().fromJson(
//                        params["events"] as String, listMapType
//                    )
//                    val eventList: List<JournalEvent> = listMap.map { map ->
//                        val id = map["id"] as String
//                        val publicName = map["publicName"] as String
//                        val iconName = map["iconName"] as String
//                        val created = map["created"] as String
//                        val modified = map["modified"] as String
//
//                        JournalEvent(id, publicName, iconName, created, modified)
//                    }
//
//                    val ratings: List<Int> = Gson().fromJson(
//                        params["ratings"] as String, ListIntType
//                    )
//
//                    val journalEntry = JournalEntry()
//
//                    val response = qa.createJournalEntry(journalEntry)
//
//                    response.success(
//                        QAFlutterPluginSerializable.serializeQAResponseString(response)
//                    )
                }
            }
        }
    }
}