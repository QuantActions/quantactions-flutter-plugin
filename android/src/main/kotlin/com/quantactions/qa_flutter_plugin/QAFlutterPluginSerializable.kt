package com.quantactions.qa_flutter_plugin

import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.QAResponse
import com.squareup.moshi.JsonClass
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

class QAFlutterPluginSerializable {
    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableTimeSeries<T>(
        val timestamps: List<String>,
        val values: List<T>,
        val confidenceIntervalLow: List<T>,
        val confidenceIntervalHigh: List<T>,
        val confidence: List<Double>,
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableQAResponse<T>(
        val data: T?,
        val message: String?
    )

    companion object {
        fun <T> serializeQAResponseString(response: QAResponse<T>): String {
            return Json.encodeToString(
                SerializableQAResponse(
                    response.data.toString(),
                    response.message.toString(),
                )
            )
        }

        fun serializeTimeSeriesDouble(timeSeries: TimeSeries.DoubleTimeSeries): String {
            return Json.encodeToString(
                SerializableTimeSeries(
                    timeSeries.timestamps.map { v -> v.toString() },
                    timeSeries.values.map { v -> if (v.isNaN()) null else v },
                    timeSeries.confidenceIntervalLow.map { v -> if (v.isNaN()) null else v },
                    timeSeries.confidenceIntervalHigh.map { v -> if (v.isNaN()) null else v },
                    timeSeries.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                )

            )
        }

        fun serializeSleepSummaryTime(timeSeries: TimeSeries.SleepSummaryTimeTimeSeries): String {
            return Json.encodeToString(
                SerializableTimeSeries(
                    timeSeries.timestamps.map { v -> v.toString() },
                    timeSeries.values.map { v -> v.serialize() },
                    timeSeries.confidenceIntervalLow.map { v -> v.serialize() },
                    timeSeries.confidenceIntervalHigh.map { v -> v.serialize() },
                    timeSeries.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                )
            )
        }

        fun serializeScreenTimeAggregate(timeSeries: TimeSeries.ScreenTimeAggregateTimeSeries): String {
            return Json.encodeToString(
                SerializableTimeSeries(
                    timeSeries.timestamps.map { v -> v.toString() },
                    timeSeries.values,
                    timeSeries.confidenceIntervalLow,
                    timeSeries.confidenceIntervalHigh,
                    timeSeries.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                )
            )
        }

        fun serializeTrend(timeSeries: TimeSeries.TrendTimeSeries): String {
            return Json.encodeToString(
                SerializableTimeSeries(
                    timeSeries.timestamps.map { v -> v.toString() },
                    timeSeries.values,
                    timeSeries.confidenceIntervalLow,
                    timeSeries.confidenceIntervalHigh,
                    timeSeries.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                )
            )
        }
    }
}