import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Stream<QAResponse<SubscriptionWithQuestionnaires>> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<QAResponse<SubscriptionWithQuestionnaires>> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  });

  Stream<QAResponse<SubscriptionWithQuestionnaires>> redeemVoucher({
    required String voucher,
  });

  Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionId();

  Future<QAResponse<SubscriptionIdResponse>> getSubscriptionIdAsync();

  Future<String> syncData();

  Future<String> getDeviceID();

  Future<String?> getFirebaseToken();

  Future<bool> getIsTablet();
}
