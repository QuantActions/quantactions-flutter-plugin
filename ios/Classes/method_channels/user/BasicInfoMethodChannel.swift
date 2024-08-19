//
//  BasicInfoMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class BasicInfoMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/basic_info", binaryMessenger: registrar.messenger())
        let instance = BasicInfoMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBasicInfo":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "getBasicInfo"
            ) {
                result(
                    QAFlutterPluginSerializable.serializeBasicInfo(
                        basicInfo: QA.shared.basicInfo ?? QuantActionsSDK.BasicInfo()
                    )
                )
            }
        case "updateBasicInfo":
            let params = call.arguments as? Dictionary<String, Any>
            
            let yearOfBirth = params?["newYearOfBirth"] as? Int ?? QuantActionsSDK.BasicInfo().yearOfBirth
            let selfDeclaredHealthy = params?["newSelfDeclaredHealthy"] as? Bool ?? QuantActionsSDK.BasicInfo().selfDeclaredHealthy
            
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
                    let a = QA.shared.basicInfo
                    result(true)
                }
            }
        default: break
        }
    }
}
