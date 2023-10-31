//
//  DeviceIdMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class DeviceMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/device_id", binaryMessenger: registrar.messenger())
        let instance = DataCollectionRunningMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getDeviceID":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "getDeviceID"
            ) {
                result(QA.shared.deviceID)
            }
        default: break
        }
    }
}
