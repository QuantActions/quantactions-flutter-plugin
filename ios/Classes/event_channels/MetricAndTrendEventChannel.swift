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
            } else {
                QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: method!)
            }
        } else {
            participationID = "138e8ff6b05d6b3c48339e2fd40f2fa8854328eb"
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
                        let result = try await QA.shared.trend(
                            participationID: participationID,
                            interval: getDateInterval(dateIntervalType),
                            trendKind: metricToAsk
                        )
                        eventSink(
                            QAFlutterPluginSerializable.serializeTrendElement(data: result as [DataPoint<TrendElement>])
                        )
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
                            let result : [DataPoint<SleepScoreElement>] = try await QA.shared.sleepScoreMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesSleepScoreElement(data: result as [DataPoint<SleepScoreElement>])
                            )
                        }
                    case "cognitive":
                        Task { [participationID] in
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.cognitiveFitnessMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            )
                        }
                    case "social":
                        Task { [participationID] in
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialEngagementMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            )
                        }
                    case "action":
                        Task { [participationID] in
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.actionSpeedMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            )
                        }
                    case "typing":
                        Task { [participationID] in
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.typingSpeedMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            )
                        }
                    case "sleep_summary":
                        Task { [participationID] in
                            let result : [DataPoint<SleepSummaryElement>]  = try await QA.shared.sleepSummaryMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesSleepSummaryElement(data: result as [DataPoint<SleepSummaryElement>])
                            )
                        }
                    case "screen_time_aggregate":
                        Task { [participationID] in
                            let result : [DataPoint<ScreenTimeAggregateElement>]  = try await QA.shared.screenTimeAggregateMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesScreenTimeAggregateElement(data: result as [DataPoint<ScreenTimeAggregateElement>])
                            )
                        }
                    case "social_taps":
                        Task { [participationID] in
                            let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialTapsMetric(
                                participationID: participationID,
                                interval: getDateInterval(dateIntervalType)
                            )
                            
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                            )
                        }
                    default: QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                        eventSink: eventSink,
                        methodName: "gerMetric \(metric)"
                    )
                    }
                }
            }
        } else {
            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: "gerMetric")
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
        
        
        let endDate : Date? = calendar.date(from: components)
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
