package com.quantactions.qa_flutter_plugin.event_channel_handlers.questionnaire

import com.google.gson.reflect.TypeToken
import com.google.gson.Gson
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class RecordQuestionnaireResponseStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    private val long = object : TypeToken<Long>() {}.type

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {
                "recordQuestionnaireResponse" -> {
                    val name = params["name"] as String?
                    val code = params["code"] as String?
                    val date: Long = Gson().fromJson(
                        params["date"] as String?, long
                    )
                    val fullID = params["fullId"] as String?
                    val response = params["response"] as String?

                    qa.recordQuestionnaireResponse(name, code, date, fullID, response).collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
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