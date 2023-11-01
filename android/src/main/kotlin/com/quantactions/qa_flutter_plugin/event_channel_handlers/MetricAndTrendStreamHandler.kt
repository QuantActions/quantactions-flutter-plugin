package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import android.util.Log
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginMetricMapper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.Calendar

class MetricAndTrendStreamHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val metricEventChannels = QAFlutterPluginHelper.listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        metricEventChannels.forEach {
            it.setStreamHandler(
                MetricAndTrendStreamHandler(mainScope, ioScope, qa, context)
            )
        }
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        ioScope.launch {
            val params = arguments as Map<*, *>

            val metric = params["metric"] as String
            val metricToAsk = QAFlutterPluginMetricMapper.getMetric(metric)
            val dateIntervalType = params["metricInterval"] as? String

            mainScope.launch {
                when (params["method"] as? String) {
                    "getMetricSample" -> {
                        val apiKey = params["apiKey"] as String?

                        if (apiKey != null) {
                            QAFlutterPluginHelper.safeEventChannel(
                                eventSink = eventSink,
                                methodName = "getMetricSample",
                                method = {
                                    eventSink.success(
                                        runBlocking {
                                            launch {
                                                qa.getMetricSample(
                                                    context = context,
                                                    apiKey = apiKey,
                                                    score = metricToAsk,
                                                    from = getFromDateInterval(dateIntervalType)
                                                ).collect {
                                                    eventSink.success(
                                                        QAFlutterPluginMetricMapper.mapMetricResponse(
                                                            metric, it
                                                        )
                                                    )
                                                }
                                            }
                                        },
                                    )
                                },
                            )
                        } else {
                            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                                eventSink = eventSink, methodName = "getMetricSample"
                            )
                        }
                    }

                    "getMetric" -> {
                        QAFlutterPluginHelper.safeEventChannel(
                            eventSink = eventSink,
                            methodName = "getMetric",
                            method = {
                                eventSink.success(
                                    runBlocking {
                                        launch {
                                            qa.getMetric(
                                                score = metricToAsk,
                                                from = getFromDateInterval(dateIntervalType)
                                            ).collect {
                                                eventSink.success(
                                                    QAFlutterPluginMetricMapper.mapMetricResponse(
                                                        metric,
                                                        it
                                                    )
                                                )
                                            }
                                        }
                                    },
                                )
                            },
                        )
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun getFromDateInterval(dateIntervalType: String?): Long {
        val calendar = Calendar.getInstance()
        val dayOfWeek = calendar[Calendar.DAY_OF_WEEK]
        val dayOfMonth = calendar[Calendar.DAY_OF_MONTH]

        return when (dateIntervalType) {
            "2weeks" -> Instant.now().minus(14, ChronoUnit.DAYS).toEpochMilli()
            "6weeks" -> Instant.now().minus(dayOfWeek.toLong(), ChronoUnit.DAYS)
                .minus(42, ChronoUnit.DAYS).toEpochMilli()

            else -> Instant.now().minus(dayOfMonth.toLong(), ChronoUnit.DAYS)
                .minus(12, ChronoUnit.MONTHS).toEpochMilli()
        }
    }
}