package com.quantactions.qa_flutter_plugin.event_channel_handlers

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginMetricMapper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking

class GetQuestionnairesListStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_questionnaires_list"
        )
        channel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as Map<*, *>

            when (params["method"]) {
                "getQuestionnairesList" -> {
                    QAFlutterPluginHelper.safeEventChannel(
                        eventSink = eventSink,
                        methodName = "getQuestionnairesList",
                        method = {
                            eventSink.success(
                                runBlocking {
                                    launch {
                                        val response = qa.getQuestionnairesList()

                                        eventSink.success(
                                            QAFlutterPluginSerializable.serializeQuestionnaireList(
                                                response
                                            )
                                        )
                                    }
                                },
                            )
                        },
                    )
                }

                "recordQuestionnaireResponse" -> {
                    val name = params["name"] as String?
                    val code = params["code"] as String?
                    val fullID = params["fullId"] as String?
                    val response = params["response"] as String?
                    val date: Long? = (params["date"] as String?)?.toLong()

                    if (name != null && code != null && fullID != null && response != null && date != null) {
                        QAFlutterPluginHelper.safeEventChannel(
                            eventSink = eventSink,
                            methodName = "recordQuestionnaireResponse",
                            method = {
                                eventSink.success(
                                    runBlocking {
                                        launch {
                                            qa.recordQuestionnaireResponse(
                                                name, code, date, fullID, response
                                            )
                                        }
                                    },
                                )
                            },
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                            eventSink = eventSink, methodName = "recordQuestionnaireResponse"
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