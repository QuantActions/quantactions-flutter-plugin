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
        
        
        let subscription = QA.shared.subscriptions
        if (subscription.isEmpty) {
            // no participation - no journal
            return nil
//            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: method!)
        }

        
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
                        if (response.isEmpty){
                            DispatchQueue.main.async {
                                eventSink(QAFlutterPluginSerializable.serializeJournalEntryList(data: [], cogScore: [], sleepScore: [], engScore: []))
                            }
                            return;
                        }
                        // retrieve scores
                        let endDate : Date? = Calendar.current.date(byAdding: .day, value: 1, to: allDates.max()!)!
                        let startDate : Date? = Calendar.current.date(byAdding: .day, value: -1, to: allDates.min()!)!

                        let cogScore : [DataPoint<DoubleValueElement>] = []
                        let sleepScore : [DataPoint<SleepScoreElement>] = []
                        let engScore : [DataPoint<DoubleValueElement>] = []
                    
                        DispatchQueue.main.async {[cogScore, sleepScore, engScore] in
                            eventSink(QAFlutterPluginSerializable.serializeJournalEntryList(data: response, cogScore: cogScore, sleepScore: sleepScore, engScore: engScore))
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
