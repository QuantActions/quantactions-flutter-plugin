package com.quantactions.qa_flutter_plugin

import android.content.Context
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class MainStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("event") as? String) {
                "init" -> {
                    val age = params["age"] as? Int? ?: 0
                    val selfDeclaredHealthy = params["age"] as? Boolean? ?: false
                    val gender =
                        QAFlutterPluginHelper.parseGender(params["gender"] as? String)

                    qa.init(
                        context,
                        QAFlutterPluginHelper.initApiKey,
                        age = age,
                        gender = gender,
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