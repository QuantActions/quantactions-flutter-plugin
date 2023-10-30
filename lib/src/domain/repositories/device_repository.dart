import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Future<Subscription?> getSubscription();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
