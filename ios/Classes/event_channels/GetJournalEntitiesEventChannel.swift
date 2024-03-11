//
//  GetJournalEntitiesEventChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class GetJournalEntitiesEventChannel : NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "qa_flutter_plugin_stream/get_journal_entries", binaryMessenger: registrar.messenger())
        let instance = GetJournalEntitiesEventChannel()
        channel.setStreamHandler(instance)
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        
        let params = arguments as? Dictionary<String, Any>
        
        let method = params?["method"] as? String
        
        if let method = method {
            switch method {
            case "journalEntries":
                QAFlutterPluginHelper.safeEventChannel(
                    eventSink: eventSink,
                    methodName: "journalEntries"
                ) {
                    Task {
                        let response = QA.shared.journalEntries()
                        let allDates = response.map{ a in a.date}
                        // retrieve scores
                        // FIXME: should retrieve the partID first
                        let endDate : Date? = Calendar.current.date(byAdding: .day, value: 1, to: allDates.max()!)!
                        let startDate : Date? = Calendar.current.date(byAdding: .day, value: -1, to: allDates.min()!)!

                        let dateInterval = DateInterval(start: startDate ?? .now, end: endDate ?? .now)
                        
                        do {
                            let cogScore = try await QA.shared.cognitiveFitnessMetric(participationID: "138e8ff6b05d6b3c48339e2fd40f2fa8854328eb",
                                                                                      interval: dateInterval)
                            let sleepScore = try await QA.shared.sleepScoreMetric(participationID: "138e8ff6b05d6b3c48339e2fd40f2fa8854328eb",
                                                                            interval: dateInterval)

                            let engScore = try await QA.shared.socialEngagementMetric(participationID: "138e8ff6b05d6b3c48339e2fd40f2fa8854328eb",
                                                                        interval: dateInterval)
                        
                        DispatchQueue.main.async {
                            eventSink(QAFlutterPluginSerializable.serializeJournalEntryList(data: response, cogScore: cogScore, sleepScore: sleepScore, engScore: engScore))
                        }
                            
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                
                }
            default: break
            }
        } else {
            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(
                eventSink: eventSink,
                methodName: "journalEntries"
            )
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
