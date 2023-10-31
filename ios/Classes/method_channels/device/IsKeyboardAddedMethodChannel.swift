//
//  IsKeyboardAddedMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class IsKeyboardAddedMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/is_keyboard_added", binaryMessenger: registrar.messenger())
        let instance = IsKeyboardAddedMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isKeyboardAdded":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "isKeyboardAdded"
            ) {
                result(QA.shared.isKeyboardAdded)
            }
        default: break
        }
    }
}
