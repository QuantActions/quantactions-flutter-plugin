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
        case "getJournalEntry":
            let dateFormatter = DateFormatter()
            let params = call.arguments as? Dictionary<String, Any>
            
            let id = params?["id"] as? String
            let dateString = params?["date"] as? String
            let note = params?["note"] as? String
            let events = params?["events"] as? String
            
            if let id = id, let dateString = dateString, let note = note, let events = events {
                Task {
                    do {
                        let journalEntry = JournalEntry(
                            date: dateFormatter.date(from: dateString) ?? Date.now,
                            note: note,
                            events: QAFlutterPluginSerializable.journalEntryEventFromJson(json: events)
                        )
                        let response = try QA.shared.saveJournalEntry(journalEntry: journalEntry)
                    } catch {
                        // TODO: return error
                    }
                }
            } else {
                //TODO: return error
            }
        default: break
        }
    }
}
