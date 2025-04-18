import Flutter
import UIKit
import QuantActionsSDK

public class QAFlutterPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        DataCollectionRunningMethodChannel.register(with: registrar)
        UserEventChannel.register(with: registrar)
        VoidMethodChannel.register(with: registrar)
        DeviceMethodChannel.register(with: registrar)
        LastTapsMethodChannel.register(with: registrar)
        IsDeviceRegisteredMethodChannel.register(with: registrar)
        IsKeyboardAddedMethodChannel.register(with: registrar)
        KeyboardSettingsMethodChannel.register(with: registrar)
        SubscribeMethodChannel.register(with: registrar)
        SubscriptionMethodChannel.register(with: registrar)
        UpdateKeyboardSettingsMethodChannel.register(with: registrar)
        UpdateFCMTokenMethodChannel.register(with: registrar)
        RequestCoreMotionAuthorizationMethodChannel.register(with: registrar)
        RequestHealthKitAuthorizationMethodChannel.register(with: registrar)
        IsHealthKitAuthorizationStatusDeterminedMethodChannel.register(with: registrar)
        CoreMotionAuthorizationStatusMethodChannel.register(with: registrar)
        GetJournalEntryMethodChannel.register(with: registrar)
        GetJournalEntriesSampleMethodChannel.register(with: registrar)
        GetJournalEventKindsMethodChannel.register(with: registrar)
        SaveJournalEntryMethodChannel.register(with: registrar)
        BasicInfoMethodChannel.register(with: registrar)
        IdentityIdMethodChannel.register(with: registrar)
        PasswordMethodChannel.register(with: registrar)
        InitMethodChannel.register(with: registrar)
        
        GetJournalEntitiesEventChannel.register(with: registrar)
        MetricAndTrendEventChannel.register(with: registrar)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}
