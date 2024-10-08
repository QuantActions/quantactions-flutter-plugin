//
//  SubscribeMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class SubscribeMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/subscribe", binaryMessenger: registrar.messenger())
        let instance = SubscribeMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "subscribe":
            let params = call.arguments as? Dictionary<String, Any>
            
            let subscriptionIdOrCohortId = params?["subscriptionIdOrCohortId"] as? String
            
            if (subscriptionIdOrCohortId != nil) {
                QAFlutterPluginHelper.safeMethodChannel(
                    result: result,
                    methodName: "subscribe"
                ) {
                    Task {
                        print("calling subscribe")
                        do {
                            let response = try await QA.shared.subscribe(participationID: subscriptionIdOrCohortId!)
                            print(response)
                            result(QAFlutterPluginSerializable.serializeSubscriptionWithQuestionnaires(data: response))
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            } else {
                QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(result: result, methodName: "subscribe")
            }
        default: break
        }
    }    
}
