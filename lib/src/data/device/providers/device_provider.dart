abstract class DeviceProvider {
  Future<bool?> isDeviceRegistered();

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

  Future<dynamic> retrieveBatteryOptimizationIntentForCurrentManufacturer();

  Future<dynamic> syncData();

  Future<String?> getSubscriptionIdAsync();
}
