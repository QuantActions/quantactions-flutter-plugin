import '../models/qa_response/qa_response.dart';
import '../models/qa_response/subscription_id_response.dart';

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

  Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionId();

  Future<QAResponse<SubscriptionIdResponse>> getSubscriptionIdAsync();

  Future<String?> retrieveBatteryOptimizationIntentForCurrentManufacturer();

  Future<String?> syncData();

  Future<String?> getDeviceID();

  Future<String?> getFirebaseToken();
}
