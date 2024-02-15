//
//  InitMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class InitMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/init", binaryMessenger: registrar.messenger())
        let instance = InitMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            let params = call.arguments as? Dictionary<String, Any>
            
            let yearOfBirth = params?["newYearOfBirth"] as? Int ?? QuantActionsSDK.BasicInfo().yearOfBirth
            let selfDeclaredHealthy = params?["age"] as? Bool ?? QuantActionsSDK.BasicInfo().selfDeclaredHealthy
            
            let newGenderString  = params?["newGender"] as? String
            let gender: Gender = (newGenderString == nil) ? QuantActionsSDK.BasicInfo().gender : QAFlutterPluginHelper.parseGender(gender: newGenderString)
            
            
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "init"
            ) {
                Task {
                    let basicInfo = BasicInfo(
                        yearOfBirth: yearOfBirth,
                        gender: gender,
                        selfDeclaredHealthy: selfDeclaredHealthy
                    )
                    
                    result(try await QA.shared.setup(basicInfo: basicInfo))
                }
            }
        default: break
        }
    }
}
