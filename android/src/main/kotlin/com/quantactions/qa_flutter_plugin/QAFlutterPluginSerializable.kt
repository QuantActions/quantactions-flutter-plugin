package com.quantactions.qa_flutter_plugin

import com.quantactions.sdk.BasicInfo
import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.data.api.adapters.SubscriptionWithQuestionnaires
import com.quantactions.sdk.data.entity.Cohort
import com.quantactions.sdk.data.model.JournalEntry
import com.quantactions.sdk.data.entity.Questionnaire
import com.quantactions.sdk.Subscription
import com.quantactions.sdk.data.entity.JournalEventEntity
import com.quantactions.sdk.data.model.JournalEntryEvent
import com.squareup.moshi.JsonClass
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
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
    data class SerializableSubscription(
        val subscriptionId: String,
        val deviceIds: List<String>,
        val cohortId: String,
        val cohortName: String,
        val premiumFeaturesTTL: Long,
        val token: String
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableSubscriptionWithQuestionnaires(
        val cohort: SerializableCohort,
        val listOfQuestionnaires: List<SerializableQuestionnaire>,
        val subscriptionId: String,
        val tapDeviceIds: List<String>,
        val premiumFeaturesTTL: Long,
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableCohort(
        val cohortId: String,
        val privacyPolicy: String?,
        val cohortName: String?,
        val dataPattern: String?,
        val canWithdraw: Int,
        val permAppId: Int?,
        val permDrawOver: Int?,
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
    data class SerializableJournalEntry(
        val id: String?,
        val timestamp: String,
        val note: String,
        val events: List<SerializableJournalEntryEvent>,
        var scores: Map<String, Int>
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableJournalEntryEvent(
        val id: String,
        val eventKindID: String,
        val eventName: String,
        val eventIcon: String,
        val rating: Int?
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableJournalEventEntity(
        val id: String,
        val publicName: String,
        val iconName: String,
        val created: String,
        val modified: String,
    )

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableBasicInfo(
        val yearOfBirth: Int,
        val gender: String,
        val selfDeclaredHealthy: Boolean,
    )

    companion object {
        fun serializeSubscriptions(
            response: List<Subscription>
        ): String {
            val result = mutableListOf<String>()

            response.forEach { item ->
                result.add(
                    Json.encodeToString(
                        SerializableSubscription(
                            item.subscriptionId,
                            item.deviceIds,
                            item.cohortId,
                            item.cohortName,
                            item.premiumFeaturesTTL,
                            item.token ?: ""
                        ),
                    ),
                )
            }

            return Json.encodeToString(result);
        }

        fun serializeSubscriptionWithQuestionnaires(
            response: SubscriptionWithQuestionnaires
        ): String {
            return Json.encodeToString(
                SerializableSubscriptionWithQuestionnaires(
                    cohortToSerializableCohort(response.cohort),
                    response.listOfQuestionnaires.map { questionnaire ->
                        questionnaireToSerializableQuestionnaire(questionnaire)
                    },
                    response.subscriptionId,
                    response.tapDeviceIds,
                    response.premiumFeaturesTTL
                ),
            )
        }

        fun serializeTimeSeriesDouble(timeSeries: TimeSeries.DoubleTimeSeries): String {
            return Json.encodeToString(
                SerializableTimeSeries(
                    timeSeries.timestamps.map { v -> v.toOffsetDateTime().toString() },
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
                    timeSeries.timestamps.map { v -> 
                        v.toOffsetDateTime().toString()
                     },
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
                    timeSeries.timestamps.map { v -> v.toOffsetDateTime().toString() },
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
                    timeSeries.timestamps.map { v -> v.toOffsetDateTime().toString() },
                    timeSeries.values,
                    timeSeries.confidenceIntervalLow,
                    timeSeries.confidenceIntervalHigh,
                    timeSeries.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                )
            )
        }

        fun serializeCohortList(cohorts: List<Cohort>): String {
            return Json.encodeToString(
                cohorts.map { cohort -> cohortToSerializableCohort(cohort) }
            )
        }

        private fun cohortToSerializableCohort(cohort: Cohort): SerializableCohort {
            return SerializableCohort(
                cohort.cohortId,
                cohort.privacyPolicy,
                cohort.cohortName,
                cohort.dataPattern,
                cohort.canWithdraw,
                cohort.permAppId,
                cohort.permDrawOver,
            )
        }

        fun serializeQuestionnaireList(questionnaires: List<Questionnaire>): String {
            return Json.encodeToString(
                questionnaires.map { questionnaire ->
                    questionnaireToSerializableQuestionnaire(questionnaire)
                }
            )
        }

        private fun questionnaireToSerializableQuestionnaire(questionnaire: Questionnaire): SerializableQuestionnaire {
            return SerializableQuestionnaire(
                questionnaire.id,
                questionnaire.questionnaireName,
                questionnaire.questionnaireDescription,
                questionnaire.questionnaireCode,
                questionnaire.questionnaireCohort,
                questionnaire.questionnaireBody,

                )
        }

        fun serializeJournalEntryList(journalEntries: List<JournalEntry>): String {
            return Json.encodeToString(
                journalEntries.map { journalEntry ->
                    SerializableJournalEntry(
                        journalEntry.id,
                        journalEntry.date.toString(),
                        journalEntry.note,
                        journalEntry.events.map { event ->
                            SerializableJournalEntryEvent(
                                event.id,
                                event.eventKindID,
                                event.eventName,
                                event.eventIcon,
                                event.rating
                            )
                        },
                        journalEntry.scores,
                    )
                }
            )
        }

        fun serializeJournalEntry(journalEntry: JournalEntry): String {
            return Json.encodeToString(
                SerializableJournalEntry(
                    journalEntry.id,
                    journalEntry.date.toString(),
                    journalEntry.note,
                    journalEntry.events.map { event ->
                        SerializableJournalEntryEvent(
                            event.id,
                            event.eventKindID,
                            event.eventName,
                            event.eventIcon,
                            event.rating
                        )
                    },
                    journalEntry.scores,
                )
            )
        }

        fun serializeJournalEventEntity(events: List<JournalEventEntity>): String {
            return Json.encodeToString(
                events.map { event ->
                    SerializableJournalEventEntity(
                        event.id,
                        event.name,
                        event.icon,
                        event.created,
                        event.modified
                    )
                }
            )
        }

        fun serializeJournalEventFromJson(json: String): List<JournalEntryEvent> {
            val list = Json.decodeFromString<List<SerializableJournalEntryEvent>>(json)

            return list.map { element ->
                JournalEntryEvent(
                    element.id,
                    element.eventKindID,
                    element.eventName,
                    element.eventIcon,
                    element.rating
                )
            }
        }

        fun serializeBasicInfo(basicInfo: BasicInfo): String {
            return Json.encodeToString(
                SerializableBasicInfo(
                    basicInfo.yearOfBirth,
                    basicInfo.gender.name,
                    basicInfo.selfDeclaredHealthy,
                )
            )
        }

        fun serializeDevicesIds(ids: List<String>): String {
            return Json.encodeToString(
                ids.map { element ->
                    element.toString()
                }
            )
        }
    }
}