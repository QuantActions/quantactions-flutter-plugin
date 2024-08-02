//
//  GetJournalEntryMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class GetJournalEntryMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/get_journal_entry", binaryMessenger: registrar.messenger())
        let instance = GetJournalEntryMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getJournalEntry":
            let params = call.arguments as? Dictionary<String, Any>
            
            let journalEntryId = params?["journalEntryId"] as? String
            
            if (journalEntryId != nil) {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "getJournalEntry"
                ) {
                    let response = QA.shared.journalEntries().first(where: {$0.id == journalEntryId})
                    Task {
                        if let response = response {
                            result(await QAFlutterPluginSerializable.serializeJournalEntry(data: response))
                        } else {
                            result(nil)
                        }
                    }
                }
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "getJournalEntry")
            }
        default: break
        }
    }
}
