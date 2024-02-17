//
//  UpdateKeyboardSettingsMethodChannel.swift
//  qa_flutter_plugin
//
//  Created by User on 15/02/2024.
//

import Foundation
import Flutter
import QuantActionsSDK

class UpdateKeyboardSettingsMethodChannel : NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "qa_flutter_plugin/update_keyboard_settings", binaryMessenger: registrar.messenger())
        let instance = UpdateKeyboardSettingsMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "updateKeyboardSettings":
            QAFlutterPluginHelper.safeMethodChannel(
                result: result,
                methodName: "updateKeyboardSettings"
            ) {
                let params = call.arguments as? Dictionary<String, Any>
                
                let caseSensitive = params?["caseSensitive"] as? Bool ?? false
                let smartPunctuation = params?["smartPunctuation"] as? Bool ?? false
                let autoCorrect = params?["autoCorrect"] as? Bool ?? false
                let autoCapitalization = params?["autoCapitalization"] as? Bool ?? false
                let autoLearn = params?["autoLearn"] as? Bool ?? false
                let doubleSpaceTapAddsPunctuation = params?["doubleSpaceTapAddsPunctuation"] as? Bool ?? false
                let swipeTyping = params?["swipeTyping"] as? Bool ?? false
                let swipeLeftToDelete = params?["swipeLeftToDelete"] as? Bool ?? false
                let autoCorrectAfterPunctuation = params?["autoCorrectAfterPunctuation"] as? Bool ?? false
                let spacebarMovesCursor = params?["spacebarMovesCursor"] as? Bool ?? false
                let hapticFeedback = params?["hapticFeedback"] as? Bool ?? false
                let soundFeedback = params?["soundFeedback"] as? Bool ?? false
                
                QA.shared.update(
                    keyboardSettings: KeyboardSettings(
                        caseSensitive: caseSensitive,
                        smartPunctuation: smartPunctuation,
                        autoCorrect: autoCorrect,
                        autoCapitalization: autoCapitalization,
                        autoLearn: autoLearn,
                        doubleSpaceTapAddsPunctuation: doubleSpaceTapAddsPunctuation,
                        swipeTyping: swipeTyping,
                        swipeLeftToDelete: swipeLeftToDelete,
                        autoCorrectAfterPunctuation: autoCorrectAfterPunctuation,
                        spacebarMovesCursor: spacebarMovesCursor,
                        hapticFeedback: hapticFeedback,
                        soundFeedback: soundFeedback
                    )
                )
                
                result(true)
            }
        default: break
        }
    }
}
