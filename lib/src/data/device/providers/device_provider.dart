abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Stream<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<dynamic> subscription();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
