import '../../../domain/domain.dart';

abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Future<String> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<dynamic> getSubscriptions();

  Future<String> getDeviceID();

  Future<String> getConnectedDevices();

  Future<bool?> getIsKeyboardAdded();

  Future<void> openBatteryOptimisationSettings();

  Future<String> getKeyboardSettings();

  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  });

  Future<bool> requestCoreMotionAuthorization();

  Future<bool> requestHealthKitAuthorization();

  Future<bool> isHealthKitAuthorizationStatusDetermined();

  Future<int> coreMotionAuthorizationStatus();
}
