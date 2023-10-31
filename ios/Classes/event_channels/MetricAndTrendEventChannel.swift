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
        
        let metric = params?["metric"] as? String
        let dateIntervalType = params?["metricInterval"] as? String
        
        if let metric = metric, let dateIntervalType = dateIntervalType {
            let metricToAsk : TrendKind? = QAFlutterPluginHelper.getTrendKind(metric: metric)
            
            if let metricToAsk = metricToAsk {
                Task {
                    do {
                        //participationID has getSubscriptionId value
                        var result = try await QA.shared.trend(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType),
                            trendKind: metricToAsk
                        )
                        eventSink(
                            QAFlutterPluginSerializable.serializeTrendElement(data: result as [DataPoint<TrendElement>])
                        )
                    } catch {
                        print(error)
                    }
                }
                
            } else {
                switch (metric) {
                case "sleep":
                    Task {
                        do {
                            let result : [DataPoint<SleepScoreElement>] = try await QA.shared.sleepScoreMetric(
                                participationID: "",
                                interval: getDateInterval(dateIntervalType)
                            )
                            eventSink(
                                QAFlutterPluginSerializable.serializeTimeSeriesSleepScoreElement(data: result as [DataPoint<SleepScoreElement>])
                            )
                        } catch {
                            print(error)
                        }
                    }
                case "cognitive":
                    Task {
                        let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.cognitiveFitnessMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                        )
                    }
                case "social":
                    Task {
                        let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialEngagementMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                        )
                    }
                case "action":
                    Task {
                        let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.actionSpeedMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                        )
                    }
                case "typing":
                    Task {
                        let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.typingSpeedMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                        )
                    }
                case "sleep_summary":
                    Task {
                        let result : [DataPoint<SleepSummaryElement>]  = try await QA.shared.sleepSummaryMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesSleepSummaryElement(data: result as [DataPoint<SleepSummaryElement>])
                        )
                    }
                case "screen_time_aggregate":
                    Task {
                        let result : [DataPoint<ScreenTimeAggregateElement>]  = try await QA.shared.screenTimeAggregateMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesScreenTimeAggregateElement(data: result as [DataPoint<ScreenTimeAggregateElement>])
                        )
                    }
                case "social_taps":
                    Task {
                        let result : [DataPoint<DoubleValueElement>]  = try await QA.shared.socialTapsMetric(
                            participationID: "",
                            interval: getDateInterval(dateIntervalType)
                        )
                        
                        eventSink(
                            QAFlutterPluginSerializable.serializeTimeSeriesDoubleValueElement(data: result as [DataPoint<DoubleValueElement>])
                        )
                    }
                default: break
                }
            }
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
