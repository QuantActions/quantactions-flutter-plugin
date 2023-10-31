//
//  GetQuestionnairesListEventChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 30/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class GetQuestionnairesListEventChannel : NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "qa_flutter_plugin_stream/get_questionnaires_list", binaryMessenger: registrar.messenger())
        let instance = GetQuestionnairesListEventChannel()
        channel.setStreamHandler(instance)
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        
        let params = arguments as? Dictionary<String, Any>
        
        let method = params?["method"] as? String
        
        if (method != nil) {
            switch method {
            case "getQuestionnairesList": break
                //TODO (Karatysh): implement when will be ready
            default: break
            }
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
