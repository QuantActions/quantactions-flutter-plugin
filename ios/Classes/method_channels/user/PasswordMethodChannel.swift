//
//  BasicInfoMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class PasswordMethodChannel : NSObject, FlutterPlugin {

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/get_password", binaryMessenger: registrar.messenger())
        let instance = PasswordMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPassword":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "getPassword"
            ) {
                result("")
            }
        default: break
        }
    }
}
