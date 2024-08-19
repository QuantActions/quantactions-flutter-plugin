//
//  MetricAndTrendEventChannel.swift
//  integration_test
//
//  Created by User on 23/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class MetricAndTrendEventChannel : NSObject, FlutterStreamHandler {
    
    
    private var eventSink: FlutterEventSink?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let instance = MetricAndTrendEventChannel()
        
        let channels = QAFlutterPluginHelper.metricChannelNames.map{
            (channelName) -> FlutterEventChannel in return FlutterEventChannel(
                name: "qa_flutter_plugin_stream/\(channelName)",
                binaryMessenger: registrar.messenger()
            )
        }
        channels.forEach { channel in
            channel.setStreamHandler(instance)
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        
        let params = arguments as? Dictionary<String, Any>
        
        let method = params?["method"] as? String
        
        var participationID = "";
        
        if (method == "getMetric") {
            let subscription = QA.shared.subscriptions
            if (!subscription.isEmpty) {
                participationID = subscription.first!.id
            } 
            else {
                QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: method!)
            }
        } else {
            participationID = "8ff6b05d-6b3c-4833-9e2f-d40f2fa88543"
        }
        
        let metric = params?["metric"] as? String
        let dateIntervalType = params?["metricInterval"] as? String
        
        if let metric = metric, let dateIntervalType = dateIntervalType {
            let metricToAsk : TrendKind? = QAFlutterPluginHelper.getTrendKind(metric: metric)
            
            if let metricToAsk = metricToAsk {
                QAFlutterPluginHelper.safeEventChannel(
                    eventSink: eventSink,
                    methodName: "getMetric\(metricToAsk)"
                ) {
                    Task { [participationID] in
                        do {
                            let result = try await QA.shared.trend(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType),
                                trendKind: metricToAsk
                            )
                            DispatchQueue.main.async {
                              // Call the desired channel message here.
                                eventSink(
                                    QAFlutterPluginSerializable.serializeTrendElement(data: result as [DataPoint<TrendElement>])
                                )
                            }
                        } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTrendElement(data: [])
                                    )
                                }
                        }
                    }
                }
            } else {
                QAFlutterPluginHelper.safeEventChannel(
                    eventSink: eventSink,
                    methodName: "getMetric\(metric)"
                ) {
                    switch (metric) {
                    case "sleep":
                        Task { [participationID] in
                            do {
                            let result : [DataPoint<SleepScoreElement>] = try await QA.shared.sleepScoreMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                                
                            DispatchQueue.main.async {
                                eventSink(
                                    QAFlutterPluginSerializable.serializeTimeSeriesSleepScoreElement(data: result as [DataPoint<SleepScoreElement>])
                                )
                            }
                            } catch _ {
                                // TODO: ugly must handle network error better
                                    DispatchQueue.main.async {
                                        eventSink(
                                            QAFlutterPluginSerializable.serializeTimeSeriesSleepScoreElement(data: [])
                                        )
                                    }
                            }
                        }
                    case "cognitive":
                        Task { [participationID] in
                            do {
                                let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.cognitiveFitnessMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                                    )
                                }
                            } catch let error {
                            print("Error \(error)")
                                if error.localizedDescription.contains("401"){
                                    print("Error 401 - Check your API key")
                                }
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: [])
                                    )
                                }
                            }
                        }
                    case "social":
                        Task { [participationID] in
                            do {
                                
                                let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialEngagementMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                let b = result as [DataPoint<DoubleValueElement>]
                                let a = QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: b)
                                DispatchQueue.main.async {
                                    eventSink(
                                        a
                                    )
                                }
                            } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: [])
                                    )
                                }
                            }
                            
                        }
                    case "action":
                        Task { [participationID] in
                            
                            do {
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.actionSpeedMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            let a = QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            DispatchQueue.main.async {
                                eventSink(
                                    a
                                )
                            }
                            } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: [])
                                    )
                                }
                            }
                        }
                    case "typing":
                        Task { [participationID] in
                            do {
                                let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.typingSpeedMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                                    )
                                }
                            } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: [])
                                    )
                                }
                            }
                        }
                    case "sleep_summary":
                        Task { [participationID] in
                            do {
                                let result : [DataPoint<SleepSummaryElement>]  = try await QA.shared.sleepSummaryMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesSleepSummaryElement(data: result as [DataPoint<SleepSummaryElement>])
                                    )
                                }
                            } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesSleepSummaryElement(data: [])
                                    )
                                }
                            }
                        }
                    case "screen_time_aggregate":
                        Task { [participationID] in
                            do {
                                let result : [DataPoint<ScreenTimeAggregateElement>]  = try await QA.shared.screenTimeAggregateMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesScreenTimeAggregateElement(data: result as [DataPoint<ScreenTimeAggregateElement>])
                                    )
                                }
                            }catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesScreenTimeAggregateElement(data: [])
                                    )
                                }
                            }
                        }
                    case "social_taps":
                        Task { [participationID] in
                            do {
                                let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialTapsMetric(
                                    participationID: participationID,
                                    interval: getDateInterval(dateIntervalType)
                                )
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                                    )
                                }
                            } catch _ {
                                DispatchQueue.main.async {
                                    eventSink(
                                        QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: [])
                                    )
                                }
                            }
                        }
                    default: QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                        eventSink: eventSink,
                        methodName: "getMetric \(metric)"
                    )
                    }
                }
            }
        } else {
            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: "getMetric")
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    
    
    private func getDateInterval(_ dateIntervalType: String) -> DateInterval {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .weekday, .weekOfYear], from: Date(timeIntervalSinceNow: 0))
        
        
        let rawOffset = TimeZone.current.secondsFromGMT() / 3600
        let endDate : Date? = calendar.date(byAdding: .hour, value: rawOffset, to: .now)
        var startDate : Date? = Date(timeIntervalSinceNow: 0)
        
        switch (dateIntervalType) {
        case "2weeks":
            startDate = calendar.date(byAdding: .day, value: -14, to: .now) ?? .now
        case "6weeks":
            let daysIn6Week = 42 + (components.weekday ?? 0)
            startDate = calendar.date(byAdding: .day, value: -daysIn6Week, to: .now) ?? .now
        default:
            if let month = components.month, let year = components.year {
                if (month == 12) {
                    components.month = 1
                } else {
                    components.year = year - 1
                }
                components.day = 1
                
                startDate = calendar.date(from: components)
            }
        }
        
        return DateInterval(start: startDate ?? .now, end: endDate ?? .now)
    }

    
}


//extension DateInterval {
//  /// Returns the duration of the `DateInterval` in days.
//  var durationInDays: Int {
//    let durationInSeconds = self.duration
//    return Int(durationInSeconds / 60.0 / 60.0 / 24.0)
//  }
//}
//
//extension DateInterval {
//  /// Returns a list of `Date` objects representing each day within the `DateInterval` at midnight.
//  func datesAtMidnight() -> [Date] {
//    let calendar = Calendar.current
//    
//    // Get the start and end dates of the interval
//    let startDate = self.start
//    let endDate = self.end
//    
//    // Create an empty array to store the dates
//    var dates = [Date]()
//    
//    // Iterate through each day within the interval
//    var currentDay = startDate
//    while currentDay <= endDate {
//      // Set the current day to midnight
//      currentDay = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: currentDay)!
//      
//      // Append the date to the array
//      dates.append(currentDay)
//      
//      // Move to the next day
//      currentDay = calendar.date(byAdding: .day, value: 1, to: currentDay)!
//    }
//    
//    return dates
//  }
//}
//
//struct DataEntry: TrendElement {
//  let date: Date
//  let value: Double
//}
//
//
//func fillMissingDays(data: [DataPoint<TrendElement>], for interval: DateInterval) -> [DataPoint<TrendElement>] {
//        
//    // Get all dates at midnight within the interval
//    let dates = interval.datesAtMidnight()
//    let a = TrendElement(
//        difference2Weeks: Double.nan,
//        statistic2Weeks: Double.nan,
//        significance2Weeks:  Double.nan,
//        difference6Weeks: Double.nan,
//        statistic6Weeks: Double.nan,
//        significance6Weeks: Double.nan,
//        difference1Year: Double.nan,
//        statistic1Year:  Double.nan,
//        significance1Year:  Double.nan
//    )
//
//
//
//    // Create a dictionary to store existing data entries by date
//    var existingData = [Date: DataEntry]()
//    for entry in data {
//    existingData[entry.date] = entry
//    }
//
//    // Fill missing days with entries at midnight and value of NaN
//    var filledData = [DataEntry]()
//    for date in dates {
//    if let existingEntry = existingData[date] {
//      filledData.append(existingEntry)
//    } else {
//      filledData.append(DataEntry(date: date, value: .nan))
//    }
//    }
//
//    return filledData
//}

