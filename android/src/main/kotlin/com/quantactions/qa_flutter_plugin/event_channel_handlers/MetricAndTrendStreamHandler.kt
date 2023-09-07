package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginMetricMapper
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class MetricAndTrendStreamHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        ioScope.launch {
            val params = arguments as Map<*, *>

            val metric = params["metric"] as String
            val metricToAsk = QAFlutterPluginMetricMapper.getMetric(metric);

            mainScope.launch {
                when (params["method"] as? String) {
                    "getMetricSample" -> {
                        val apiKey = params["apiKey"] as String

                        qa.getMetricSample(context, apiKey, metricToAsk).collect {
                            eventSink.success(
                                QAFlutterPluginMetricMapper.mapMetricResponse(metric, it)
                            )
                        }
                    }

                    "getMetric" -> {
                        qa.getMetric(metricToAsk).collect {
                            eventSink.success(
                                QAFlutterPluginMetricMapper.mapMetricResponse(metric, it)
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