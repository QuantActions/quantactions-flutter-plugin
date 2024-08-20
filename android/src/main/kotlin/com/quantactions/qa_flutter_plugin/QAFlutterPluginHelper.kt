package com.quantactions.qa_flutter_plugin

import com.quantactions.sdk.Metric
import com.quantactions.sdk.QA
import com.quantactions.sdk.Trend
import com.quantactions.sdk.QA.Gender
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class QAFlutterPluginHelper {
    companion object {
        val listOfMetricsAndTrends = listOf(
            Metric.COGNITIVE_FITNESS,
            Metric.ACTION_SPEED,
            Metric.TYPING_SPEED,
            Metric.SOCIAL_ENGAGEMENT,
            Metric.SLEEP_SUMMARY,
            Metric.SLEEP_SCORE,
            Metric.SCREEN_TIME_AGGREGATE,
            Metric.SOCIAL_TAPS,
            Metric.BEHAVIOURAL_AGE,
            Trend.COGNITIVE_FITNESS,
            Trend.ACTION_SPEED,
            Trend.SOCIAL_ENGAGEMENT,
            Trend.SLEEP_SCORE,
            Trend.SLEEP_LENGTH,
            Trend.SLEEP_INTERRUPTIONS,
            Trend.SOCIAL_SCREEN_TIME,
            Trend.SOCIAL_TAPS,
            Trend.TYPING_SPEED,
            Trend.THE_WAVE,
        )

        fun parseGender(gender: String?): Gender {
            return when (gender) {
                "male" -> QA.Gender.MALE
                "female" -> QA.Gender.FEMALE
                "other" -> QA.Gender.OTHER
                else -> QA.Gender.UNKNOWN
            }
        }

       suspend fun safeMethodChannel(
            result: MethodChannel.Result,
            methodName: String,
            method: suspend () -> Unit
        ) {
            try {
                method()
            } catch (e: Exception) {
                result.error(
                    "0",
                    "$methodName method failed",
                    e.localizedMessage,
                )
            }
        }

        suspend fun safeEventChannel(
            eventSink: EventChannel.EventSink, methodName: String,
            method: suspend () -> Unit
        ) {
            try {
                method()
            } catch (e: Exception) {
                eventSink.error(
                    "0",
                    "$methodName method failed",
                    e.localizedMessage,
                )
            }
        }

        fun returnInvalidParamsMethodChannelError(
            result: MethodChannel.Result,
            methodName: String
        ) {
            result.error(
                "0",
                "$methodName method failed",
                "invalids params"
            )
        }

        fun returnInvalidParamsEventChannelError(
            eventSink: EventChannel.EventSink,
            methodName: String
        ) {
            eventSink.error(
                "0",
                "$methodName method failed",
                "invalids params"
            )
        }
    }
}