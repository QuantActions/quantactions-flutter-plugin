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
import kotlinx.coroutines.Job
import java.time.LocalDate
import java.time.ZoneOffset
import java.time.temporal.ChronoUnit

class MetricAndTrendStreamHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var mainEventSink: EventChannel.EventSink? = null
    private var job: Job? = null

    fun destroy() {
        mainEventSink = null
        job?.cancel()
    }

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding): List<MetricAndTrendStreamHandler> {
        val metricEventChannels = QAFlutterPluginHelper.listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        val handlers = metricEventChannels.map {
            val thisHandler = MetricAndTrendStreamHandler(mainScope, ioScope, qa, context)
            it.setStreamHandler(
                thisHandler
            )
            thisHandler
        }
        return handlers
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.mainEventSink = eventSink

        job = ioScope.launch {
            val params = arguments as Map<*, *>

            val metric = params["metric"] as String
            val metricToAsk = QAFlutterPluginMetricMapper.getMetric(metric)
            val dateIntervalType = params["metricInterval"] as? String
            val refresh = params["refresh"] as? Boolean
            val fromLocalDate =
                getFromDateInterval(dateIntervalType)
            val toLocalDate = LocalDate.now()

            when (params["method"] as? String) {
                "getMetricSample" -> {
                    val apiKey = params["apiKey"] as String?
                    if (apiKey != null) {
                        qa.getMetricSample(
                            context = context,
                            apiKey = apiKey,
                            score = metricToAsk,
                            from = fromLocalDate.atStartOfDay()
                                .toInstant(ZoneOffset.UTC).toEpochMilli(),
                            to = toLocalDate.atStartOfDay().plusDays(1)
                                .toInstant(ZoneOffset.UTC)
                                .toEpochMilli()
                        ).collect{
                            val rewindDays = ChronoUnit.DAYS.between(
                                fromLocalDate,
                                toLocalDate
                            ).toInt() - it.timestamps.size

                            mainScope.launch {
                                mainEventSink?.success(
                                    QAFlutterPluginMetricMapper.mapMetricResponse(
                                        metric, it.fillMissingDays(
                                            rewindDays = rewindDays,
                                            inplace = true,
                                        )
                                    )
                                )
                            }
                        }



                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                            eventSink = eventSink, methodName = "getMetricSample"
                        )
                    }
                }

                "getMetric" -> {
                    qa.getMetric(
                        score = metricToAsk,
                        from = fromLocalDate.atStartOfDay()
                            .toInstant(ZoneOffset.UTC)
                            .toEpochMilli(),
                        to = toLocalDate.atStartOfDay().plusDays(30)
                            .toInstant(ZoneOffset.UTC)
                            .toEpochMilli(),
                        refresh = refresh ?: false
                    ).collect {
                        val rewindDays = ChronoUnit.DAYS.between(
                            fromLocalDate,
                            toLocalDate
                        ).toInt() - it.timestamps.size
                        mainScope.launch {
                            mainEventSink?.success(
                                QAFlutterPluginMetricMapper.mapMetricResponse(
                                    metric, it.fillMissingDays(
                                        rewindDays = rewindDays,
                                        inplace = true,
                                    )
                                )
                            )
                        }
                    }


                }
            }

        }
    }

    override fun onCancel(arguments: Any?) {
        mainEventSink = null
        job?.cancel()
    }

    private fun getFromDateInterval(dateIntervalType: String?): LocalDate {
        val currentDate = LocalDate.now()

        return when (dateIntervalType) {
            "2weeks" -> currentDate.minusDays(14)

            "6weeks" -> currentDate.minusDays(currentDate.dayOfWeek.value.toLong()).minusWeeks(5)

            else -> currentDate.minusDays(currentDate.dayOfMonth.toLong()).minusMonths(11)
        }
    }
}