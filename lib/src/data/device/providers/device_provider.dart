abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Future<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<dynamic> getSubscriptions();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
