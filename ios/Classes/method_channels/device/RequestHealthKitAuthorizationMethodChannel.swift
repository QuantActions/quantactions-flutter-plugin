//
//  RequestHealthKitAuthorizationMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 17/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class RequestHealthKitAuthorizationMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/request_health_kit_authorization", binaryMessenger: registrar.messenger())
        let instance = RequestHealthKitAuthorizationMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "requestHealthKitAuthorization":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "requestHealthKitAuthorization"
            ) {
                Task {
                    result(try await QA.shared.requestHealthKitAuthorization())
                }
            }
        default: break
        }
    }
}
