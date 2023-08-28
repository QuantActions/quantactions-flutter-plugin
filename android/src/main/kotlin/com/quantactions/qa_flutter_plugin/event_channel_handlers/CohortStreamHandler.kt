package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.data.entity.Cohort
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class CohortStreamHandler(
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
                "getCohortList" -> {
                    qa.getCohortList().collect {
                        eventSink.success(QAFlutterPluginSerializable.serializeCohortList(it))
                    }
                }

                "leaveCohort" -> {
                    val cohortId = params["cohortId"] as? String

                    if (cohortId != null) {
                        qa.leaveCohort(cohortId).collect {
                            eventSink.success(
                                QAFlutterPluginSerializable.serializeQAResponseString(it)
                            )
                        }
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}