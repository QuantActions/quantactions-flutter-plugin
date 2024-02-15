import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<List<Subscription>> getSubscriptions();

  Future<String> getDeviceID();

  Future<List<String>> getConnectedDevices();

  Future<bool?> getIsKeyboardAdded();

  Future<void> openBatteryOptimisationSettings();

  Future<KeyboardSettings> keyboardSettings();

  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  });
}
