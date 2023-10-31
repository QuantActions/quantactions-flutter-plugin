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
                        basicInfo: QuantActionsSDK.BasicInfo()
                    )
                )
            }
        default: break
        }
    }
}
