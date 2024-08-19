//
//  SaveJournalEntryMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class SaveJournalEntryMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/save_journal_entry", binaryMessenger: registrar.messenger())
        let instance = SaveJournalEntryMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "saveJournalEntry":
            let dateFormatter = DateFormatter()
            // Set the date format to match the string format
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            let params = call.arguments as? Dictionary<String, Any>
            
            let id = params?["id"] as? String
            let dateString = params?["date"] as? String
            let note = params?["note"] as? String
            let events = params?["events"] as? String
            
            if let dateString = dateString, let note = note, let events = events {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "saveJournalEntry"
                ) {
                    Task {
                        let journalEntry = JournalEntry(
                            date: dateFormatter.date(from: dateString) ?? Date.now,
                            note: note,
                            events: QAFlutterPluginSerializable.journalEntryEventFromJson(json: events)
                        )
                        if (id != nil){
                            try QA.shared.deleteJournalEntry(byID: id!)
                        }
                        
                        do {
                            
                            let response = try QA.shared.saveJournalEntry(journalEntry: journalEntry)
                            result(await QAFlutterPluginSerializable.serializeJournalEntry(data: response))
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "saveJournalEntry")
            }
        default: break
        }
    }
}
