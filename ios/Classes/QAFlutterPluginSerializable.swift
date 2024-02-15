//
//  QAFlutterPluginSerializable.swift
//  qa_flutter_plugin
//
//  Created by User on 21/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

struct SerializableBasicInfo : Encodable {
    public var yearOfBirth: Int
    public var gender: String
    public var selfDeclaredHealthy: Bool
}

struct SerializableKeyboardSettings: Encodable{
    public var caseSensitive: Bool
    public var smartPunctuation: Bool
    public var autoCorrect: Bool
    public var autoCapitalization: Bool
    public var autoLearn: Bool
    public var doubleSpaceTapAddsPunctuation: Bool
    public var swipeTyping: Bool
    public var swipeLeftToDelete: Bool
    public var autoCorrectAfterPunctuation: Bool
    public var spacebarMovesCursor: Bool
    public var hapticFeedback: Bool
    public var soundFeedback: Bool
}

struct SerializableTimeSeries<T : Encodable> : Encodable {
    public var timestamps: [String]
    public var values: [T]
    public var confidenceIntervalLow: [T]
    public var confidenceIntervalHigh: [T]
    public var confidence: [Double]
}

struct SerializableTrendElement : Encodable {
    public var difference2Weeks: Double?
    public var statistic2Weeks: Double?
    public var significance2Weeks: Double?
    public var difference6Weeks: Double?
    public var statistic6Weeks: Double?
    public var significance6Weeks: Double?
    public var difference1Year: Double?
    public var statistic1Year: Double?
    public var significance1Year: Double?
}

struct SerializableSleepSummaryElement : Encodable {
    public var sleepDate: String
    public var interruptionsStart: [String]
    public var interruptionsStop: [String]
    public var interruptionsNumberOfTaps: [Int]
}

struct SerializableScreenTimeAggregateElement : Encodable {
    public var screenTime: Double
    public var socialScreenTime: Double
}

struct SerializableSubscriptionWithQuestionnaires : Encodable {
    public var cohort: SerializableCohort
    public var questionnaires: [SerializableQuestionnaire]
    public var subscriptionID: String
    public var tapDeviceIDs: [String]
    public var premiumFeaturesTTL: Int
}

struct SerializableSubscription : Encodable {
    public var subscriptionId: String
    public var deviceIds: [String]
    public var cohortId: String
    public var cohortName: String
    public var premiumFeaturesTTL: Int
}

struct SerializableCohort : Encodable {
    public var id: String
    public var name: String
    public var privacyPolicy: String
    public var canWidthdraw: Bool
}

struct SerializableQuestionnaire : Encodable {
    public var id: String
    public var name: String
    public var description: String
    public var code: String
    public var cohortID: String
    public var body: String
}

struct SerializableJournalEntry : Encodable {
    public var id: String
    public var date: String
    public var note: String
    public var events: [SerializableJournalEntryEvent]
}

struct SerializableJournalEntryEvent : Encodable, Decodable {
    public var id: String
    public var eventKindID: String
    public var rating: Int
}

struct SerializableJournalEventKind : Encodable {
    public var id: String
    public var publicName: String
    public var iconName: String
}

class QAFlutterPluginSerializable : NSObject {
    
    public static func serializeBasicInfo(basicInfo: BasicInfo) -> String {
        let serializableBasicInfo = SerializableBasicInfo(
            yearOfBirth: basicInfo.yearOfBirth,
            gender: String(describing: basicInfo.gender),
            selfDeclaredHealthy: basicInfo.selfDeclaredHealthy
        )
        
        return encodeObject(object: serializableBasicInfo)
    }
    
    public static func serializeKeyboardSettings(keyboardSettings: KeyboardSettings) -> String {
        
        let serializableKeyboardSettings = SerializableKeyboardSettings(
            caseSensitive: keyboardSettings.caseSensitive,
            smartPunctuation: keyboardSettings.smartPunctuation,
            autoCorrect: keyboardSettings.autoCorrect,
            autoCapitalization: keyboardSettings.autoCapitalization,
            autoLearn: keyboardSettings.autoLearn,
            doubleSpaceTapAddsPunctuation: keyboardSettings.doubleSpaceTapAddsPunctuation,
            swipeTyping: keyboardSettings.swipeTyping,
            swipeLeftToDelete: keyboardSettings.swipeLeftToDelete,
            autoCorrectAfterPunctuation: keyboardSettings.autoCorrectAfterPunctuation,
            spacebarMovesCursor: keyboardSettings.spacebarMovesCursor,
            hapticFeedback: keyboardSettings.hapticFeedback,
            soundFeedback: keyboardSettings.soundFeedback
        )
        
        return encodeObject(object: serializableKeyboardSettings)
    }
    
    
    public static func serializeTimeSeriesSleepSummaryElement(data: [DataPoint<SleepSummaryElement>]) -> String {
        let dateFormatter = DateFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableSleepSummaryElement?] = []
        
        for val in data{
            timestamps.append(dateFormatter.string(from: val.date))
            if let sleepSummaryElement = val.element {
                let serializedElement = serializeSleepSummaryElement(sleepSummaryElement: sleepSummaryElement)
                values.append(serializedElement)
            } else {
                values.append(nil)
            }
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableSleepSummaryElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: [],
            confidenceIntervalHigh: [],
            confidence: []
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTrendElement(data: [DataPoint<TrendElement>]) -> String {
        let dateFormatter = DateFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableTrendElement?] = []
        
        for val in data{
            timestamps.append(dateFormatter.string(from: val.date))
            if let trendElement = val.element {
                let serializedElement : SerializableTrendElement = serializeTrendElement(trendElement: trendElement)
                values.append(serializedElement)
            } else {
                values.append(nil)
            }
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableTrendElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: [],
            confidenceIntervalHigh: [],
            confidence: []
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTimeSeriesSleepScoreElement(data: [DataPoint<SleepScoreElement>]) -> String {
        let dateFormatter = DateFormatter()
        
        var timestamps : [String] = []
        var values : [Double?] = []
        var confidenceIntervalLow : [Double?] = []
        var confidenceIntervalHigh : [Double?] = []
        var confidence : [Double] = []
        
        for val in data{
            timestamps.append(dateFormatter.string(from: val.date))
            values.append(val.element == nil ? nil : val.element!.sleepScore)
            confidenceIntervalLow.append(val.element == nil ? nil : val.element!.confidenceIntervalLow)
            confidenceIntervalHigh.append(val.element == nil ? nil : val.element!.confidenceIntervalHigh)
            confidence.append(val.element!.confidence)
        }
        
        let serializableTimeSeries = SerializableTimeSeries<Double?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: confidenceIntervalLow,
            confidenceIntervalHigh: confidenceIntervalHigh,
            confidence: confidence
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTimeSeriesDoubleValueElement(data: [DataPoint<DoubleValueElement>]) -> String {
        let dateFormatter = DateFormatter()
        
        var timestamps : [String] = []
        var values : [Double?] = []
        var confidenceIntervalLow : [Double?] = []
        var confidenceIntervalHigh : [Double?] = []
        
        for val in data{
            timestamps.append(dateFormatter.string(from: val.date))
            values.append(val.element == nil ? nil : val.element!.value)
            confidenceIntervalLow.append(val.element == nil ? nil : val.element!.confidenceIntervalLow)
            confidenceIntervalHigh.append(val.element == nil ? nil : val.element!.confidenceIntervalHigh)
        }
        
        let serializableTimeSeries = SerializableTimeSeries<Double?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: confidenceIntervalLow,
            confidenceIntervalHigh: confidenceIntervalHigh,
            confidence: []
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTimeSeriesScreenTimeAggregateElement(data: [DataPoint<ScreenTimeAggregateElement>]) -> String {
        let dateFormatter = DateFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableScreenTimeAggregateElement?] = []
        
        for val in data{
            timestamps.append(dateFormatter.string(from: val.date))
            values.append(val.element == nil ? nil : serializeScreenTimeAggregateElement(screenTimeAggregateElement: val.element!))
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableScreenTimeAggregateElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: [],
            confidenceIntervalHigh: [],
            confidence: []
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeSubscriptionWithQuestionnaires(data: SubscriptionWithQuestionnaires) -> String {
        let serializableObject = SerializableSubscriptionWithQuestionnaires(
            cohort: serializeCohort(cohort: data.cohort),
            questionnaires: serializeQuestionnaireList(questionnaires: data.questionnaires),
            subscriptionID: data.subscriptionID,
            tapDeviceIDs: data.tapDeviceIDs,
            premiumFeaturesTTL: data.premiumFeaturesTTL
        )
        
        return encodeObject(object: serializableObject)
    }
    
    public static func serializeSubscription(data: [Subscription]) -> String {
        let dateFormatter = DateFormatter()
        
        var dataArray : [SerializableSubscription] = []
        
        for x in data {
            dataArray.append(
                SerializableSubscription(
                    subscriptionId:  x.id,
                    deviceIds: x.deviceIDs,
                    cohortId: x.cohortID,
                    cohortName: x.cohortName,
                    premiumFeaturesTTL: x.premiumFeaturesTTL
                )
            )
        }

        return encodeObject(object: dataArray)
    }
    
    public static func serializeJournalEntryList(data: [JournalEntry]) -> String {
        let dateFormatter = DateFormatter()
        
        var dataArray : [SerializableJournalEntry] = []
        
        for x in data {
            dataArray.append(
                SerializableJournalEntry(
                    id: x.id,
                    date: dateFormatter.string(from: x.date),
                    note: x.note,
                    events: x.events.map{
                        (journalEntryEvent) -> SerializableJournalEntryEvent in return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent)
                    }
                )
            )
        }

        return encodeObject(object: dataArray)
    }
    
    public static func serializeJournalEntry(data: JournalEntry) -> String {
        let dateFormatter = DateFormatter()
        
        let entry = SerializableJournalEntry(
            id: data.id,
            date: dateFormatter.string(from: data.date),
            note: data.note,
            events: data.events.map{
                (journalEntryEvent) -> SerializableJournalEntryEvent in return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent)
            }
        )

        return encodeObject(object: entry)
    }
    
    public static func serializeJournalEntryFromQAModel (data: JournalEntry) -> String {
        let dateFormatter = DateFormatter()
        
        let serializableObject =  SerializableJournalEntry(
            id: data.id,
            date: dateFormatter.string(from: data.date),
            note: data.note,
            events: data.events.map{
                (journalEntryEvent) -> SerializableJournalEntryEvent in return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent)
            }
        )
        
        return encodeObject(object: serializableObject)
    }
    
    public static func serializeJournalEventKind(data: [JournalEventKind]) -> String {
        let dateFormatter = DateFormatter()
        
        var dataArray : [SerializableJournalEventKind] = []
        
        for x in data {
            dataArray.append(
                SerializableJournalEventKind(
                    id: x.id,
                    publicName: x.publicName,
                    iconName: x.iconName
                )
            )
        }

        return encodeObject(object: dataArray)
    }
    
    public static func journalEntryEventFromJson(json: String) -> [JournalEntryEvent] {
        var selializad : [SerializableJournalEntryEvent] = []
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = json.data(using: .utf8)!
            
            selializad = try jsonDecoder.decode(
                [SerializableJournalEntryEvent].self,
                from: jsonData
            )
        } catch {
            print(error)
        }
        
        return journalEntryEventFromSerializable(data: selializad)
    }
    
    private static func serializeCohort(cohort: Cohort) -> SerializableCohort {
        return SerializableCohort(
            id: cohort.id,
            name: cohort.name,
            privacyPolicy: cohort.privacyPolicy,
            canWidthdraw: cohort.canWidthdraw
        )
    }
    
    private static func serializeQuestionnaireList(questionnaires: [Questionnaire]) -> [SerializableQuestionnaire] {
        
        let questionnaireList = questionnaires.map{
            (questionnaire) -> SerializableQuestionnaire in return serializeQuestionnaire(questionnaire: questionnaire)
        }
        return questionnaireList;
    }
    
    private static func serializeQuestionnaire(questionnaire: Questionnaire) -> SerializableQuestionnaire {
        return SerializableQuestionnaire(
            id: questionnaire.id,
            name: questionnaire.name,
            description: questionnaire.description,
            code: questionnaire.code,
            cohortID: questionnaire.cohortID,
            body: questionnaire.body
        )
    }
    
    private static func serializeTrendElement(trendElement: TrendElement) -> SerializableTrendElement {
        return SerializableTrendElement(
            difference2Weeks: trendElement.difference2Weeks,
            statistic2Weeks: trendElement.statistic2Weeks,
            significance2Weeks: trendElement.significance2Weeks,
            difference6Weeks: trendElement.difference6Weeks,
            statistic6Weeks: trendElement.statistic6Weeks,
            significance6Weeks: trendElement.significance6Weeks,
            difference1Year: trendElement.difference1Year,
            statistic1Year: trendElement.statistic1Year,
            significance1Year: trendElement.significance1Year
        )
    }
    
    private static func serializeSleepSummaryElement(sleepSummaryElement: SleepSummaryElement) -> SerializableSleepSummaryElement {
        let dateFormatter = DateFormatter()
        
        return SerializableSleepSummaryElement(
            sleepDate: dateFormatter.string(from: sleepSummaryElement.sleepDate),
            interruptionsStart: sleepSummaryElement.interruptionsStart.map({ (start) -> String in
                return dateFormatter.string(from: start)
            }),
            interruptionsStop: sleepSummaryElement.interruptionsStop.map({ (stop) -> String in
                return dateFormatter.string(from: stop)
            }),
            interruptionsNumberOfTaps: sleepSummaryElement.interruptionsNumberOfTaps
        )
    }
    
    private static func serializeScreenTimeAggregateElement(screenTimeAggregateElement: ScreenTimeAggregateElement) -> SerializableScreenTimeAggregateElement {
        return SerializableScreenTimeAggregateElement(
            screenTime: screenTimeAggregateElement.screenTime,
            socialScreenTime: screenTimeAggregateElement.socialScreenTime
        )
    }
    
    private static func serializeJournalEntryEvent(journalEntryEvent: JournalEntryEvent) -> SerializableJournalEntryEvent {
        return SerializableJournalEntryEvent(
            id: journalEntryEvent.id,
            eventKindID: journalEntryEvent.eventKindID,
            rating: journalEntryEvent.rating
        )
    }
    
    private static func journalEntryEventFromSerializable(data: [SerializableJournalEntryEvent]) -> [JournalEntryEvent] {
        let dateFormatter = DateFormatter()
        
        var dataArray : [JournalEntryEvent] = []
        
        for x in data {
            dataArray.append(
                JournalEntryEvent(
                    eventKindID: x.eventKindID,
                    rating: x.rating
                )
            )
        }
        
        return dataArray
    }
    
    private static func encodeObject<T: Encodable>(object: T) -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(object)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        return jsonString
    }
}
