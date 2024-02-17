//
//  CoreMotionAuthorizationStatusMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 17/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class CoreMotionAuthorizationStatusMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/core_motion_authorization_status", binaryMessenger: registrar.messenger())
        let instance = IsHealthKitAuthorizationStatusDeterminedMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "CoreMotionAuthorizationStatus":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "CoreMotionAuthorizationStatus"
            ) {
                result(QA.shared.coreMotionAuthorizationStatus.rawValue)
            }
        default: break
        }
    }
}