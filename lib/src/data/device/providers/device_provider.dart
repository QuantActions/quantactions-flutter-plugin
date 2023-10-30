abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Future<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<dynamic> getSubscription();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
