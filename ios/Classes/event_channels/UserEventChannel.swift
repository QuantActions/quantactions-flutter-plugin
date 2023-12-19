//
//  UserEventChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 21/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class UserEventChannel : NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "qa_flutter_plugin_stream/user", binaryMessenger: registrar.messenger())
        let instance = UserEventChannel()
        channel.setStreamHandler(instance)
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        
        let params = arguments as? Dictionary<String, Any>
        
        let method = params?["method"] as? String
        
        if let method = method {
            switch method {
            case "init":
                let age = params?["age"] as? Int ?? 0
                let selfDeclaredHealthy = params?["age"] as? Bool ?? false
                let gender = QAFlutterPluginHelper.parseGender(gender: params?["gender"] as? String)
                
                QAFlutterPluginHelper.safeEventChannel(
                    eventSink: eventSink,
                    methodName: "leaveCohort"
                ) {
                    Task {
                        let basicInfo = BasicInfo(
                            yearOfBirth: age,
                            gender: gender,
                            selfDeclaredHealthy: selfDeclaredHealthy
                        )
                        eventSink(
                            try await QA.shared.setup(basicInfo: basicInfo)
                        )
                    }
                }
            default: break
            }
        } else {
            QAFlutterPluginHelper.returnInvalidParamsEventChannelError(eventSink: eventSink, methodName: "init")
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
