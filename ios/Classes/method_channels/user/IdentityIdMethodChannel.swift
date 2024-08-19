//
//  BasicInfoMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class IdentityIdMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/get_identity_id", binaryMessenger: registrar.messenger())
        let instance = IdentityIdMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getIdentityId":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "getIdentityId"
            ) {
                result("")
            }
        default: break
        }
    }
}
