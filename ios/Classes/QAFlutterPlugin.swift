import Flutter
import UIKit
import QuantActionsSDK

@globalActor
enum PushActor {
    actor ActorType {}

    static let shared: ActorType = .init()
}

public class QAFlutterPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        MainMethodChannel.register(with: registrar)
        
        UserEventChannel.register(with: registrar)
        LeaveCohortEventChannel.register(with: registrar)
        GetCohortListEventChannel.register(with: registrar)
        GetSubscriptionIdEventChannel.register(with: registrar)
        DeviceEventChannel.register(with: registrar)
        MetricAndTrendEventChannel.register(with: registrar)
        GetJournalEventsEventChannel.register(with: registrar)
        GetJournalEventChannel.register(with: registrar)
        JournalEventChannel.register(with: registrar)
        GetCohortListEventChannel.register(with: registrar)
        GetQuestionnairesListEventChannel.register(with: registrar)
        RecordQuestionnaireResponseEventChannel.register(with: registrar)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {}
}
