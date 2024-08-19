//
//  DeviceIdMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class LastTapsMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/last_taps", binaryMessenger: registrar.messenger())
        let instance = LastTapsMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getLastTaps":
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "getLastTaps"
                ) {
                    let params = call.arguments as? Dictionary<String, Any>
                    let backwardDays = params?["backwardDays"] as? Int ?? 2
                    let calendar = Calendar.current
                    let startDate = calendar.date(byAdding: .day, value: -backwardDays, to: .now)
                    let dateInterval = DateInterval(start: startDate ?? .now, end: .now)

                    result(QA.shared.tapEvents(in: dateInterval).count)
                }
            default: break
        }
    }
}
