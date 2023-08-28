package com.quantactions.qa_flutter_plugin

import android.content.Context
import com.quantactions.sdk.Metric
import com.quantactions.sdk.QA
import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.Trend
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.Flow
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
            getMetric(arguments as String).collect {
                // her I have to map the return types
                mainScope.launch {
                    when (arguments) {
                        "sleep", "cognitive", "social", "action", "typing", "social_taps" -> {
                            eventSink.success(
                                QAFlutterPluginSerializable.serializeTimeSeriesDouble(
                                    it as TimeSeries.DoubleTimeSeries
                                )
                            )
                        }

                        "sleep_summary" -> {
                            eventSink.success(
                                QAFlutterPluginSerializable.serializeSleepSummaryTime(
                                    it as TimeSeries.SleepSummaryTimeTimeSeries
                                )
                            )
                        }

                        "screen_time_aggregate" -> {
                            eventSink.success(
                                QAFlutterPluginSerializable.serializeScreenTimeAggregate(
                                    it as TimeSeries.ScreenTimeAggregateTimeSeries
                                )
                            )
                        }

                        else -> {
                            eventSink.success(
                                QAFlutterPluginSerializable.serializeTrend(
                                    it as TimeSeries.TrendTimeSeries
                                )
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

    private fun getMetric(metric: String): Flow<TimeSeries<out Any>> {
        val metricToAsk = when (metric) {
            "sleep" -> Metric.SLEEP_SCORE
            "cognitive" -> Metric.COGNITIVE_FITNESS
            "social" -> Metric.SOCIAL_ENGAGEMENT
            "action" -> Metric.ACTION_SPEED
            "typing" -> Metric.TYPING_SPEED
            "sleep_summary" -> Metric.SLEEP_SUMMARY
            "screen_time_aggregate" -> Metric.SCREEN_TIME_AGGREGATE
            "social_taps" -> Metric.SOCIAL_TAPS;
            "sleep_trend" -> Trend.SLEEP_SCORE
            "cognitive_trend" -> Trend.COGNITIVE_FITNESS
            "social_engagement_trend" -> Trend.SOCIAL_ENGAGEMENT
            "action_trend" -> Trend.ACTION_SPEED
            "typing_trend" -> Trend.TYPING_SPEED
            "sleep_length_trend" -> Trend.SLEEP_LENGTH
            "sleep_interruptions_trend" -> Trend.SLEEP_INTERRUPTIONS
            "social_screen_time_trend" -> Trend.SOCIAL_SCREEN_TIME
            "social_taps_trend" -> Trend.SOCIAL_TAPS
            "the_wave_trend" -> Trend.THE_WAVE
            else -> Metric.SLEEP_SCORE

        }

        return qa.getMetricSample(context, QAFlutterPluginHelper.initApiKey, metricToAsk)
    }
}