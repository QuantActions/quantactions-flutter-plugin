import Flutter
import UIKit
import QuantActionsSDK

public class QAFlutterPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        VoidMethodChannel.register(with: registrar)
        DeviceMethodChannel.register(with: registrar)
        IsDeviceRegisteredMethodChannel.register(with: registrar)
        SubscribeMethodChannel.register(with: registrar)
        SubscriptionMethodChannel.register(with: registrar)
        IsKeyboardAddedMethodChannel.register(with: registrar)
        GetJournalEntryMethodChannel.register(with: registrar)
        SaveJournalEntryMethodChannel.register(with: registrar)
        BasicInfoMethodChannel.register(with: registrar)
        InitMethodChannel.register(with: registrar)
        
        MetricAndTrendEventChannel.register(with: registrar)
        GetCohortListEventChannel.register(with: registrar)
        GetQuestionnairesListEventChannel.register(with: registrar)
        GetJournalEntitiesEventChannel.register(with: registrar)
        GetJournalEventKindsEventChannel.register(with: registrar)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}
