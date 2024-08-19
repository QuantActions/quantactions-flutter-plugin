//
//  IsHealthKitAuthorizationStatusDeterminedMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 17/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class IsHealthKitAuthorizationStatusDeterminedMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/is_health_kit_authorization_status_determined", binaryMessenger: registrar.messenger())
        let instance = IsHealthKitAuthorizationStatusDeterminedMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isHealthKitAuthorizationStatusDetermined":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "isHealthKitAuthorizationStatusDetermined"
            ) {
                result(QA.shared.isHealthKitAuthorizationStatusDetermined)
            }
        default: break
        }
    }
}
