//
//  GetJournalEventKindsEventChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class GetJournalEventKindsMethodChannel : NSObject, FlutterPlugin {
    private var eventSink: FlutterEventSink?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/get_journal_event_kinds", binaryMessenger: registrar.messenger())
        let instance = GetJournalEventKindsMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let params = call.arguments as? Dictionary<String, Any>
        
        let method = params?["method"] as? String
        
        if let method = method{
            switch method {
            case "journalEventKinds":
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "journalEventKinds"
                ) {
                    let response = QA.shared.journalEventKinds()
                    result(QAFlutterPluginSerializable.serializeJournalEventKind(data: response))
                }
            default: break
            }
        } else {
            QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                result: result,
                methodName: "journalEventKinds"
            )
        }
    }
}
