//
//  RequestCoreMotionAuthorizationMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 17/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class RequestCoreMotionAuthorizationMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/request_core_motion_authorization", binaryMessenger: registrar.messenger())
        let instance = RequestCoreMotionAuthorizationMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "requestCoreMotionAuthorization":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "requestCoreMotionAuthorization"
            ) {
                Task {
                    result(try await QA.shared.requestCoreMotionAuthorization())
                }
            }
        default: break
        }
    }
}
