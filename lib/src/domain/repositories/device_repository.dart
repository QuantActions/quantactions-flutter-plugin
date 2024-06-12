import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<List<Subscription>> getSubscriptions();

  Future<String> getDeviceID();

  Future<int> getLastTaps({required int backwardDays});

  Future<List<dynamic>> getConnectedDevices();

  Future<bool?> getIsKeyboardAdded();

  Future<void> openBatteryOptimisationSettings();

  Future<KeyboardSettings> keyboardSettings();

  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  });

  Future<void> updateFCMToken({
    required String token,
  });

  Future<bool> requestCoreMotionAuthorization();

  Future<bool> requestHealthKitAuthorization();

  Future<bool> isHealthKitAuthorizationStatusDetermined();

  Future<AuthorizationStatus> coreMotionAuthorizationStatus();
}
