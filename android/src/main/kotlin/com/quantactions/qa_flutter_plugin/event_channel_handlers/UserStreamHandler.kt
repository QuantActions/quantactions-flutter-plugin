package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class UserStreamHandler(
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
                "init" -> {
                    val apiKey = params["apiKey"] as String
                    val age = params["age"] as? Int? ?: 0
                    val selfDeclaredHealthy = params["age"] as? Boolean? ?: false
                    val gender =
                        QAFlutterPluginHelper.parseGender(params["gender"] as? String)

                    qa.init(
                        context,
                        apiKey,
                        age,
                        gender,
                        selfDeclaredHealthy,
                    ).collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "validateToken" -> {
                    val apiKey = params["apiKey"] as? String? ?: ""

                    qa.validateToken(context, apiKey).collect {
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