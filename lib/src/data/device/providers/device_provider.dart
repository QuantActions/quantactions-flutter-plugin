abstract class DeviceProvider {
  Future<bool> isDeviceRegistered();

  Stream<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<dynamic> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  });

  Stream<dynamic> redeemVoucher({
    required String voucher,
  });

  Stream<dynamic> getSubscriptionId();

  Future<String> retrieveBatteryOptimizationIntentForCurrentManufacturer();

  Future<String> syncData();

  Future<String?> getSubscriptionIdAsync();

  Future<String> getDeviceID();

  Future<String?> getFirebaseToken();

  Future<bool> getIsTablet();
}
