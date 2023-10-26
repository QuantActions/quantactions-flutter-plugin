//
//  MainMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 20/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class MainMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = MainMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "someOtherMethod":
            result("Success!")
        case "initAsync":
            let params = call.arguments as? Dictionary<String, Any>
            
//            let apiKey = params?["apiKey"] as! String
//            let age = params!["age"] as? Int ?? 0
//            let selfDeclaredHealthy = params?["selfDeclaredHealthy"] as? Bool ?? false
//            let gender = QAFlutterPluginHelper.parseGender(gender: params?["gender"] as? String)
            
        
        case "updateBasicInfo":
            let params = call.arguments as? Dictionary<String, Any>
            
//            let newYearOfBirth = params?["newYearOfBirth"] as? Int ?? QuantActionsSDK.BasicInfo().yearOfBirth
//            let newSelfDeclaredHealthy = params?["age"] as? Bool ?? QuantActionsSDK.BasicInfo().selfDeclaredHealthy
            
            let newGenderString = params?["newGender"] as? String
            let _: Gender = (newGenderString == nil) ? QuantActionsSDK.BasicInfo().gender : QAFlutterPluginHelper.parseGender(gender: newGenderString)
            
            // TODO: add result()
        case "getDeviceID":
            result(QA.shared.deviceID)
        case "canDraw": break
            // TODO: remove break and add result()
        case "canUsage": break
            // TODO: remove break and add result()
        case "isDataCollectionRunning":
            result(QA.shared.isDataCollectionRunning)
        case "pauseDataCollection":
            result(QA.shared.pauseDataCollection)
        case "resumeDataCollection":
            result(QA.shared.resumeDataCollection)
        case "isInit": break
            result(QA.shared.isDeviceRegistered)
        case "isDeviceRegistered":
            result(QA.shared.isDeviceRegistered)
        case "setVerboseLevel":
            let params = call.arguments as? Dictionary<String, Any>
            
            let verbose = params?["verbose"] as! Int
            
            // TODO: add result()
        case "getSubscriptionIdAsync": break
            // TODO: remove break and add result()
        case "getMetricAsync": break
            // TODO: remove break and add result() with implementation
        case "getStatSampleAsync": break
            // TODO: remove break and add result() with implementation
        case "getBasicInfo":
            Task {
                result(
                    try QAFlutterPluginSerializable.serializeBasicInfo(
                        basicInfo: QuantActionsSDK.BasicInfo()
                    )
                )
            }
        case "syncData": break
            // TODO: check this method
            // result(await QA.shared.syncData())
        default:
            result(nil)
        }
    }
}
