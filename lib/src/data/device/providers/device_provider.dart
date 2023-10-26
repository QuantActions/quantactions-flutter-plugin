abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Stream<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<dynamic> getSubscriptionId();

  Future<String> syncData();

  Future<String?> getSubscriptionIdAsync();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
