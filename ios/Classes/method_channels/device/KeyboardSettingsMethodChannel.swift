//
//  KeyboardSettingsMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 15/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class KeyboardSettingsMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/keyboard_settings", binaryMessenger: registrar.messenger())
        let instance = IsKeyboardAddedMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "keyboardSettings":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "keyboardSettings"
            ) {
                
                result(
                    QAFlutterPluginSerializable.serializeKeyboardSettings(
                        keyboardSettings: QA.shared.keyboardSettings
                    )
                )
            }
        default: break
        }
    }
}
