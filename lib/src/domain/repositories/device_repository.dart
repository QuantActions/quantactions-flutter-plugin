import '../models/models.dart';

/// Device Repository.
abstract class DeviceRepository {
  /// Check if the device is registered.
  Future<bool> isDeviceRegistered();

  /// Subscribe to a subscription or cohort.
  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  });

  /// Get subscriptions.
  Future<List<Subscription>> getSubscriptions();

  /// Get device ID.
  Future<String> getDeviceID();

  /// Get last taps in the requested past days.
  Future<int> getLastTaps({required int backwardDays});

  /// Get connected devices.
  Future<List<dynamic>> getConnectedDevices();

  /// [iOS only] Check if the keyboard is added.
  Future<bool?> getIsKeyboardAdded();

  /// [Android only] Open battery optimisation settings.
  Future<void> openBatteryOptimisationSettings();

  /// [iOS only] Get keyboard settings.
  Future<KeyboardSettings> keyboardSettings();

  /// [iOS only] Update keyboard settings.
  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  });

  /// Update firebase token.
  Future<void> updateFCMToken({
    required String token,
  });

  /// [iOS only] Request CoreMotion authorization.
  Future<bool> requestCoreMotionAuthorization();

  /// [iOS only] Request HealthKit authorization.
  Future<bool> requestHealthKitAuthorization();

  /// [iOS only] Check if HealthKit authorization status is determined.
  Future<bool> isHealthKitAuthorizationStatusDetermined();

  /// [iOS only] Get CoreMotion authorization status.
  Future<AuthorizationStatus> coreMotionAuthorizationStatus();

  /// Sync data
  Future<void> syncData();
}
