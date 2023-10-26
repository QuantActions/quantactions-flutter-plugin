import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Stream<QAResponse<SubscriptionWithQuestionnaires>> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionId();

  Future<QAResponse<SubscriptionIdResponse>> getSubscriptionIdAsync();

  Future<String> syncData();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
