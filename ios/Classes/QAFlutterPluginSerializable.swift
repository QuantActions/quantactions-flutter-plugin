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
    public var shouldUseCustomBackground: Bool
}

struct SerializableTimeSeries<T : Encodable> : Encodable {
    public var timestamps: [String]
    public var values: [T]
    public var confidenceIntervalLow: [T]
    public var confidenceIntervalHigh: [T]
    public var confidence: [T]
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
    public var sleepStart: String
    public var sleepEnd: String
    public var interruptionsStart: [String]
    public var interruptionsEnd: [String]
    public var interruptionsNumberOfTaps: [Int]
}

struct SerializableScreenTimeAggregateElement : Encodable {
    public var totalScreenTime: Double
    public var socialScreenTime: Double
}

struct SerializableSubscriptionWithQuestionnaires : Encodable {
    public var cohort: SerializableCohort
    public var listOfQuestionnaires: [SerializableQuestionnaire]
    public var subscriptionId: String
    public var tapDeviceIds: [String]
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
    public var cohortId: String
    public var cohortName: String
    public var privacyPolicy: String
    public var canWithdraw: Int
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
    public var timestamp: String
    public var note: String
    public var events: [SerializableJournalEntryEvent]
    public var scores: Dictionary<String, Int>
}

struct SerializableJournalEntryEvent : Encodable, Decodable {
    public var id: String
    public var eventKindID: String
    public var eventName: String
    public var eventIcon: String
    public var rating: Int
}

struct SerializableJournalEventKind : Encodable {
    public var id: String
    public var publicName: String
    public var iconName: String
}

extension String {
  func replaceTimeWithZeros() -> String {
    return self.prefix(11) + "00:00:00" + self.dropFirst(19) // Add timezone back
  }
}

extension Date {
//    func epochMilliseconds() -> Int {
//        return Int(self.timeIntervalSince1970 * 1000)
//    }
    func epochSeconds() -> Int {
        return Int(self.timeIntervalSince1970)
    }
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
    
    public static func serializeKeyboardSettings(keyboardSettings: KeyboardSettings, shouldUseCustomBackground: Bool) -> String {
        
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
            soundFeedback: keyboardSettings.soundFeedback,
            shouldUseCustomBackground: shouldUseCustomBackground
        )
        
        return encodeObject(object: serializableKeyboardSettings)
    }
    

    public static func serializeTimeSeriesSleepSummaryElement(data: [DataPoint<SleepSummaryElement>]) -> String {
        let dateFormatter = getDateTimeFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableSleepSummaryElement?] = []
        var confidenceIntervalLow : [SerializableSleepSummaryElement?] = []
        var confidenceIntervalHigh : [SerializableSleepSummaryElement?] = []
        var confidence : [SerializableSleepSummaryElement?] = []
        
        for val in data{
            
            if let sleepSummaryElement = val.element {
//                print("In sleep : \(val.date)")
//                timestamps.append(getDateTimeFormatterTZ(inDate: val.date, tz: sleepSummaryElement.timeZone))
                timestamps.append(getDateTimeFormatterTZ(inDate: sleepSummaryElement.wakeDate, tz: sleepSummaryElement.timeZone) + "=t")
                let serializedElement = serializeSleepSummaryElement(sleepSummaryElement: sleepSummaryElement)
                values.append(serializedElement)
            } else {
                timestamps.append("\(val.date.epochSeconds())=\(TimeZone.current.identifier)")
                values.append(nil)
            }
            confidenceIntervalLow.append(nil)
            confidenceIntervalHigh.append(nil)
            confidence.append(nil)
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableSleepSummaryElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: confidenceIntervalLow,
            confidenceIntervalHigh: confidenceIntervalHigh,
            confidence: confidence
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTrendElement(data: [DataPoint<TrendElement>]) -> String {
        let dateFormatter = getDateTimeFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableTrendElement?] = []
        var confidenceIntervalLow : [SerializableTrendElement?] = []
        var confidenceIntervalHigh : [SerializableTrendElement?] = []
        var confidence : [SerializableTrendElement?] = []
        
        for val in data{
            timestamps.append("\(val.date.epochSeconds())=\(TimeZone.current.identifier)")
            if let trendElement = val.element {
                let serializedElement : SerializableTrendElement = serializeTrendElement(trendElement: trendElement)
                values.append(serializedElement)
            } else {
                values.append(nil)
            }
            confidenceIntervalLow.append(nil)
            confidenceIntervalHigh.append(nil)
            confidence.append(nil)
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableTrendElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: confidenceIntervalLow,
            confidenceIntervalHigh: confidenceIntervalHigh,
            confidence: confidence
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeTimeSeriesSleepScoreElement(data: [DataPoint<SleepScoreElement>]) -> String {
        let dateFormatter = getDateTimeFormatter()
        
        var timestamps : [String] = []
        var values : [Double?] = []
        var confidenceIntervalLow : [Double?] = []
        var confidenceIntervalHigh : [Double?] = []
        var confidence : [Double?] = []
        
        for val in data{
            timestamps.append("\(val.date.epochSeconds())=\(TimeZone.current.identifier)")
            values.append(val.element == nil ? nil : val.element!.sleepScore)
            confidenceIntervalLow.append(val.element == nil ? nil : val.element!.confidenceIntervalLow)
            confidenceIntervalHigh.append(val.element == nil ? nil : val.element!.confidenceIntervalHigh)
            confidence.append(val.element == nil ? nil : val.element!.confidence)
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
        let dateFormatter = getDateTimeFormatter()
        
        var timestamps : [String] = []
        var values : [Double?] = []
        var confidence : [Double?] = []
        var confidenceIntervalLow : [Double?] = []
        var confidenceIntervalHigh : [Double?] = []
        
        for val in data{
            timestamps.append("\(val.date.epochSeconds())=\(TimeZone.current.identifier)")
            values.append(val.element == nil ? nil : val.element!.value)
            confidenceIntervalLow.append(val.element == nil ? nil : val.element!.confidenceIntervalLow)
            confidenceIntervalHigh.append(val.element == nil ? nil : val.element!.confidenceIntervalHigh)
            confidence.append(nil)
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
    
    public static func serializeTimeSeriesScreenTimeAggregateElement(data: [DataPoint<ScreenTimeAggregateElement>]) -> String {
        let dateFormatter = getDateTimeFormatter()
        
        var timestamps : [String] = []
        var values : [SerializableScreenTimeAggregateElement?] = []
        var confidenceIntervalLow : [SerializableScreenTimeAggregateElement?] = []
        var confidenceIntervalHigh : [SerializableScreenTimeAggregateElement?] = []
        var confidence : [SerializableScreenTimeAggregateElement?] = []
        
        for val in data{
            timestamps.append("\(val.date.epochSeconds())=\(TimeZone.current.identifier)")
            values.append(val.element == nil ? nil : serializeScreenTimeAggregateElement(screenTimeAggregateElement: val.element!))
            confidenceIntervalLow.append(nil)
            confidenceIntervalHigh.append(nil)
            confidence.append(nil)
        }
        
        let serializableTimeSeries = SerializableTimeSeries<SerializableScreenTimeAggregateElement?>(
            timestamps: timestamps,
            values: values,
            confidenceIntervalLow: confidenceIntervalLow,
            confidenceIntervalHigh: confidenceIntervalHigh,
            confidence: confidence
        )
        
        return encodeObject(object: serializableTimeSeries)
    }
    
    public static func serializeSubscriptionWithQuestionnaires(data: SubscriptionWithQuestionnaires) -> String {
        let serializableObject = SerializableSubscriptionWithQuestionnaires(
            cohort: serializeCohort(cohort: data.cohort),
            listOfQuestionnaires: serializeQuestionnaireList(questionnaires: data.questionnaires),
            subscriptionId: data.subscriptionID,
            tapDeviceIds: data.tapDeviceIDs,
            premiumFeaturesTTL: data.premiumFeaturesTTL
        )
        
        return encodeObject(object: serializableObject)
    }
    
    public static func serializeSubscription(data: [Subscription]) -> String {
//        let dateFormatter = getDateTimeFormatter()
        
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
    
    public static func serializeJournalEntryList(data: [JournalEntry],
                                                 cogScore: [DataPoint<DoubleValueElement>],
                                                 sleepScore: [DataPoint<SleepScoreElement>],
                                                 engScore: [DataPoint<DoubleValueElement>]
    ) -> String {
        let dateFormatter = getSimpleDateTimeFormatter()
        
        var dataArray : [SerializableJournalEntry] = []
        let eventKinds = QA.shared.journalEventKinds();
        
        for x in data {
            
            var scores = [String: Int]();
            
            let cogElement: DataPoint<DoubleValueElement>? = cogScore.first{a in Calendar.current.startOfDay(for: a.date) == Calendar.current.startOfDay(for: x.date)}
            let cogValue: Double? = cogElement?.element?.value
            
            let sleepElement: DataPoint<SleepScoreElement>? = sleepScore.first{a in Calendar.current.startOfDay(for: a.date) == Calendar.current.startOfDay(for: x.date)}
            let sleepValue: Double? = sleepElement?.element?.sleepScore
            
            let engElement: DataPoint<DoubleValueElement>? = engScore.first{a in Calendar.current.startOfDay(for: a.date) == Calendar.current.startOfDay(for: x.date)}
            let engValue: Double? = engElement?.element?.value
            
            
            if cogValue != nil && !cogValue!.isNaN {
                scores["003-001-001-003"] = Int(cogValue!);
            }
            
            if sleepValue != nil && !sleepValue!.isNaN {
                scores["003-001-001-002"] = Int(sleepValue!);
            }
            
            if engValue != nil && !engValue!.isNaN {
                scores["003-001-001-004"] = Int(engValue!);
            }
            
            dataArray.append(
                SerializableJournalEntry(
                    id: x.id,
                    timestamp: dateFormatter.string(from: x.date),
                    note: x.note,
                    events: x.events.map{
                        journalEntryEvent in
                        let ee = eventKinds.filter{ek in journalEntryEvent.eventKindID == ek.id}.first;
                        return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent, eventName: ee!.publicName, eventIcon: ee!.publicName);
                    },
                    scores: scores
                )
            )
        }

        return encodeObject(object: dataArray)
    }
    
    public static func serializeJournalEntry(data: JournalEntry) -> String {
        let dateFormatter = getSimpleDateTimeFormatter()
        
        let eventKinds = QA.shared.journalEventKinds()

        let entry = SerializableJournalEntry(
            id: data.id,
            timestamp: dateFormatter.string(from: data.date),
            note: data.note,
            events: data.events.map {
                journalEntryEvent in
                let ee = eventKinds.filter{ek in journalEntryEvent.eventKindID == ek.id}.first;
                return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent, eventName: ee!.publicName, eventIcon: ee!.publicName);
            },
            scores: [String: Int]()
        )

        return encodeObject(object: entry)
    }
    
    public static func serializeJournalEntryFromQAModel (data: JournalEntry) -> String {
        let dateFormatter = getSimpleDateTimeFormatter()
        let eventKinds = QA.shared.journalEventKinds()
        
        let serializableObject =  SerializableJournalEntry(
            id: data.id,
            timestamp: dateFormatter.string(from: data.date),
            note: data.note,
            events: data.events.map {
                journalEntryEvent in
                let ee = eventKinds.filter{ek in journalEntryEvent.eventKindID == ek.id}.first;
                return serializeJournalEntryEvent(journalEntryEvent: journalEntryEvent, eventName: ee!.publicName, eventIcon: ee!.publicName);
            },
            scores: [String: Int]()
        )
        
        return encodeObject(object: serializableObject)
    }
    
    public static func serializeJournalEventKind(data: [JournalEventKind]) -> String {
//        let dateFormatter = getDateTimeFormatter()
        
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
            cohortId: cohort.id,
            cohortName: cohort.name,
            privacyPolicy: cohort.privacyPolicy,
            canWithdraw: cohort.canWidthdraw ? 1 : 0
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
//        let dateFormatter = getDateTimeFormatter()
        
        return SerializableSleepSummaryElement(
            sleepStart: getDateTimeFormatterTZ(inDate: sleepSummaryElement.sleepDate, tz: sleepSummaryElement.timeZone),
            sleepEnd: getDateTimeFormatterTZ(inDate: sleepSummaryElement.wakeDate, tz: sleepSummaryElement.timeZone),
            interruptionsStart: sleepSummaryElement.interruptionsStart.map({ (start) -> String in
                return getDateTimeFormatterTZ(inDate: start, tz: sleepSummaryElement.timeZone)
            }),
            interruptionsEnd: sleepSummaryElement.interruptionsStop.map({ (stop) -> String in
                return getDateTimeFormatterTZ(inDate: stop, tz: sleepSummaryElement.timeZone)
            }),
            interruptionsNumberOfTaps: sleepSummaryElement.interruptionsNumberOfTaps
        )
    }
    
    private static func serializeScreenTimeAggregateElement(screenTimeAggregateElement: ScreenTimeAggregateElement) -> SerializableScreenTimeAggregateElement {
        return SerializableScreenTimeAggregateElement(
            totalScreenTime: screenTimeAggregateElement.screenTime,
            socialScreenTime: screenTimeAggregateElement.socialScreenTime
        )
    }
    
    private static func serializeJournalEntryEvent(journalEntryEvent: JournalEntryEvent, eventName: String, eventIcon: String) -> SerializableJournalEntryEvent {
        return SerializableJournalEntryEvent(
            id: journalEntryEvent.id,
            eventKindID: journalEntryEvent.eventKindID,
            eventName: eventName,
            eventIcon: eventIcon,
            rating: journalEntryEvent.rating
        )
    }
    
    private static func journalEntryEventFromSerializable(data: [SerializableJournalEntryEvent]) -> [JournalEntryEvent] {
//        let dateFormatter = getDateTimeFormatter()
        
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
    
    struct Foo: Codable {
        var string: String? = nil
        var number: Int = 1

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(number, forKey: .number)
            try container.encode(string, forKey: .string)
        }
    }
    
    private static func getSimpleDateTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }
    
    private static func getDateTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter
    }
    
    private static func getDateTimeFormatterTZ(inDate: Date, tz: String) -> String {
        return "\(inDate.epochSeconds())=\(tz)"
    }
    
}
