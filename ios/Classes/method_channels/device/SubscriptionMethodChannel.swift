//
//  SubscriptionMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class SubscriptionMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/subscription", binaryMessenger: registrar.messenger())
        let instance = SubscriptionMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "subscription":
            Task {
                do {
                    let response = try await QA.shared.subscription()
                    
                    if (response == nil){
                        result(nil)
                    } else {
                        result(QAFlutterPluginSerializable.serializeSubscription(data: response!))
                    }
                } catch {
                    // TODO: return error
                }
            }
    
        default: break
        }
    }
}
