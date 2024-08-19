package com.quantactions.qa_flutter_plugin

import android.util.Log
import com.quantactions.sdk.Metric
import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.Trend
import com.quantactions.sdk.data.entity.TimestampedEntity

class QAFlutterPluginMetricMapper {
    companion object {
        fun getMetric(metric: String): Metric<out TimestampedEntity, out Any> {
            return when (metric) {
                "sleep" -> Metric.SLEEP_SCORE
                "cognitive" -> Metric.COGNITIVE_FITNESS
                "social" -> Metric.SOCIAL_ENGAGEMENT
                "action" -> Metric.ACTION_SPEED
                "typing" -> Metric.TYPING_SPEED
                "sleep_summary" -> Metric.SLEEP_SUMMARY
                "screen_time_aggregate" -> Metric.SCREEN_TIME_AGGREGATE
                "social_taps" -> Metric.SOCIAL_TAPS
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
        }

        fun mapMetricResponse(metric: String, response: TimeSeries<out Any>?): String? {
            if (response == null) {
                return null
            }

            when (metric) {
                "sleep", "cognitive", "social", "action", "typing", "social_taps" -> {
                    return QAFlutterPluginSerializable.serializeTimeSeriesDouble(
                        response as TimeSeries.DoubleTimeSeries

                    )
                }

                "sleep_summary" -> {
                    return QAFlutterPluginSerializable.serializeSleepSummaryTime(
                        response as TimeSeries.SleepSummaryTimeTimeSeries
                    )
                }

                "screen_time_aggregate" -> {
                    return QAFlutterPluginSerializable.serializeScreenTimeAggregate(
                        response as TimeSeries.ScreenTimeAggregateTimeSeries
                    )
                }

                else -> {
                    return QAFlutterPluginSerializable.serializeTrend(
                        response as TimeSeries.TrendTimeSeries
                    )
                }
            }
        }
    }
}