//
//  MainMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 20/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class VoidMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = VoidMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "someOtherMethod":
            result("Success!")
        case "updateBasicInfo":
            let params = call.arguments as? Dictionary<String, Any>
            
            let yearOfBirth = params?["newYearOfBirth"] as? Int ?? QuantActionsSDK.BasicInfo().yearOfBirth
            let selfDeclaredHealthy = params?["age"] as? Bool ?? QuantActionsSDK.BasicInfo().selfDeclaredHealthy
            
            let newGenderString  = params?["newGender"] as? String
            let gender: Gender = (newGenderString == nil) ? QuantActionsSDK.BasicInfo().gender : QAFlutterPluginHelper.parseGender(gender: newGenderString)
            
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "updateBasicInfo"
            ) {
                Task {
                    let basicInfo = BasicInfo(
                        yearOfBirth: yearOfBirth,
                        gender: gender,
                        selfDeclaredHealthy: selfDeclaredHealthy
                    )
                    
                    try await QA.shared.update(basicInfo: basicInfo)
                }
            }
            
        case "leaveCohort":
            let params = call.arguments as? Dictionary<String, Any>
            
            let participationID = params?["participationID"] as? String
            
            if let participationID = participationID {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "leaveCohort"
                ) {
                    Task {
                        try await QA.shared.leaveCohort(participationID: participationID)
                    }
                }
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "leaveCohort")
            }
        case "sendNote":
            let params = call.arguments as? Dictionary<String, Any>
            
            let text = params?["text"] as? String
            
            if let text = text {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "sendNote"
                ) {
                    Task {
                        try await QA.shared.sendNote(text: text)
                    }
                }
                
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "sendNote")
            }
        case "deleteJournalEntry":
            let params = call.arguments as? Dictionary<String, Any>
            
            let id = params?["id"] as? String
            
            if let id = id {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "deleteJournalEntry"
                ) {
                    Task {
                        try QA.shared.deleteJournalEntry(byID: id)
                    }
                }
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "deleteJournalEntry")
            }
        case "pauseDataCollection":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "pauseDataCollection"
            ) {
                result(QA.shared.pauseDataCollection)
            }
        case "resumeDataCollection":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "resumeDataCollection"
            ) {
                result(QA.shared.resumeDataCollection)
            }
        case "recordQuestionnaireResponse": break
            //TODO: implement when will be ready
        default: break
        }
    }
}