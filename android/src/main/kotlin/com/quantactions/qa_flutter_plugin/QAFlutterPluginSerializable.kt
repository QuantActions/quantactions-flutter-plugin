package com.quantactions.qa_flutter_plugin

import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.QAResponse
import com.quantactions.sdk.data.entity.Cohort
import com.quantactions.sdk.data.entity.JournalEvent
import com.quantactions.sdk.data.entity.Questionnaire
import com.quantactions.sdk.data.model.JournalEntryWithEvents
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

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableCohort(
        val cohortId: String,
        val privacyPolicy: String?,
        val cohortName: String?,
        val dataPattern: String?,
        val gpsResolution: Int,
        val canWithdraw: Int,
        val syncOnScreenOff: Int?,
        val perimeterCheck: Int?,
        val permAppId: Int?,
        val permLocation: Int?,
        val permContact: Int?,
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableQuestionnaire(
        val id: String,
        val questionnaireName: String,
        val questionnaireDescription: String,
        val questionnaireCode: String,
        val questionnaireCohort: String,
        val questionnaireBody: String
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableJournalEntryWithEvents(
        val id: String,
        val timestamp: Long,
        val note: String,
        val events: List<SerializableResolvedJournalEvent>,
        val ratings: List<Int>,
        var scores: Map<String, Int>
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableResolvedJournalEvent(
        val id: String,
        val publicName: String,
        val iconName: String
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableJournalEvents(
        val id: String,
        val publicName: String,
        val iconName: String,
        val created: String,
        val modified: String,
    )

    companion object {
        fun <T> serializeQAResponseString(response: QAResponse<T>): String {
            return Json.encodeToString(
                SerializableQAResponse(
                    if (response.data == null) null else response.data.toString(),
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

        fun serializeCohortList(cohorts: List<Cohort>): String {
            return Json.encodeToString(
                cohorts.map { cohort ->
                    SerializableCohort(
                        cohort.cohortId,
                        cohort.privacyPolicy,
                        cohort.cohortName,
                        cohort.dataPattern,
                        cohort.gpsResolution,
                        cohort.canWithdraw,
                        cohort.syncOnScreenOff,
                        cohort.perimeterCheck,
                        cohort.permAppId,
                        cohort.permLocation,
                        cohort.permContact,
                    )
                }
            )
        }

        fun serializeQuestionnaireList(questionnaires: List<Questionnaire>): String {
            return Json.encodeToString(
                questionnaires.map { questionnaire ->
                    SerializableQuestionnaire(
                        questionnaire.id,
                        questionnaire.questionnaireName,
                        questionnaire.questionnaireDescription,
                        questionnaire.questionnaireCode,
                        questionnaire.questionnaireCohort,
                        questionnaire.questionnaireBody,
                    )
                }
            )
        }

        fun serializeJournalEntryWithEvents(journalEntries: List<JournalEntryWithEvents>): String {
            return Json.encodeToString(
                journalEntries.map { journalEntry ->
                    SerializableJournalEntryWithEvents(
                        journalEntry.id,
                        journalEntry.timestamp,
                        journalEntry.note,
                        journalEntry.events.map { event ->
                            SerializableResolvedJournalEvent(
                                event.id,
                                event.publicName,
                                event.iconName
                            )
                        },
                        journalEntry.ratings,
                        journalEntry.scores,
                    )
                }
            )
        }

        fun serializeJournalEntry(journalEntry: JournalEntryWithEvents): String {
            return Json.encodeToString(
                SerializableJournalEntryWithEvents(
                    journalEntry.id,
                    journalEntry.timestamp,
                    journalEntry.note,
                    journalEntry.events.map { event ->
                        SerializableResolvedJournalEvent(
                            event.id,
                            event.publicName,
                            event.iconName
                        )
                    },
                    journalEntry.ratings,
                    journalEntry.scores,
                )
            )
        }

        fun serializeJournalEvents(events: List<JournalEvent>): String {
            return Json.encodeToString(
                events.map { event ->
                    SerializableJournalEvents(
                        event.id,
                        event.public_name,
                        event.icon_name,
                        event.created,
                        event.modified

                    )
                }
            )
        }
    }
}