//
//  GetJournalEntryMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class GetJournalEntriesSampleMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/get_journal_entries_sample", binaryMessenger: registrar.messenger())
        let instance = GetJournalEntriesSampleMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "journalEntriesSample":
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "getJournalEntry"
                ) {
                    Task {
                        result("[]")
                    }
                }
        default: break
        }
    }
}
