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
                        eventSink(QAFlutterPluginSerializable.serializeJournalEntryList(data: response))
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
