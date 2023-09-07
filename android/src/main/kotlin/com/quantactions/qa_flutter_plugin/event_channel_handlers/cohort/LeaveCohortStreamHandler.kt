package com.quantactions.qa_flutter_plugin.event_channel_handlers.cohort

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class LeaveCohortStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {
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