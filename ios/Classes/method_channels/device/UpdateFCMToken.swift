//
//  UpdateKeyboardSettingsMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 15/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class UpdateFCMTokenMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/update_fcm_token", binaryMessenger: registrar.messenger())
        let instance = UpdateFCMTokenMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "updateFCMToken":
            let params = call.arguments as? Dictionary<String, Any>
            let token = params?["token"] as? String ?? ""

            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "updateFCMToken"
            ) {
                QA.shared.update(pushNotificationsToken: token)
                result(true)
            }

        default: break
        }
    }
}
