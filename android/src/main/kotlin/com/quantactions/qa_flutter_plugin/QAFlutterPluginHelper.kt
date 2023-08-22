package com.quantactions.qa_flutter_plugin

import com.quantactions.sdk.Metric
import com.quantactions.sdk.QA
import com.quantactions.sdk.Trend
import com.quantactions.sdk.QA.Gender

class QAFlutterPluginHelper {
    companion object {
        const val initApiKey = "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9"

        val listOfMetricsAndTrends = listOf(
            Metric.COGNITIVE_FITNESS,
            Metric.ACTION_SPEED,
            Metric.TYPING_SPEED,
            Metric.SOCIAL_ENGAGEMENT,
            Metric.SLEEP_SUMMARY,
            Metric.SLEEP_SCORE,
            Metric.SCREEN_TIME_AGGREGATE,
            Metric.SOCIAL_TAPS,
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
                "cognitive" -> QA.Gender.MALE
                "social" -> QA.Gender.FEMALE
                "other" -> QA.Gender.OTHER
                else -> QA.Gender.UNKNOWN
            }
        }
    }
}