//
//  DataCollectionRunningMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 31/10/2023.
//

import Foundation
import Flutter
import QuantActionsSDK

class DataCollectionRunningMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/data_collection_running", binaryMessenger: registrar.messenger())
        let instance = DataCollectionRunningMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isDataCollectionRunning":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "isDataCollectionRunning"
            ) {
                result(QA.shared.isDataCollectionRunning)
            }
        default: break
        }
    }
}
