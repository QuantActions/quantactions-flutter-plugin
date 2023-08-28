import '../models/qa_response/qa_response.dart';

abstract class DeviceRepository {
  Future<bool?> isDeviceRegistered();

  Stream<QAResponse<String>> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<QAResponse<String>> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  });

  Stream<QAResponse<String>> redeemVoucher({
    required String voucher,
  });

  Stream<QAResponse<String>> getSubscriptionId();

  Future<dynamic> retrieveBatteryOptimizationIntentForCurrentManufacturer();

  Future<dynamic> syncData();

  Future<QAResponse<String>> getSubscriptionIdAsync();
}
