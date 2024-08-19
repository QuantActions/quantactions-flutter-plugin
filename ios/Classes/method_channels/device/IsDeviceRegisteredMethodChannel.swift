//
//  IsDeviceRegisteredMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class IsDeviceRegisteredMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/is_device_registered", binaryMessenger: registrar.messenger())
        let instance = IsDeviceRegisteredMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isDeviceRegistered":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "isDeviceRegistered"
            ) {
                result(QA.shared.isDeviceRegistered)
            }
        default: break
        }
    }
}
