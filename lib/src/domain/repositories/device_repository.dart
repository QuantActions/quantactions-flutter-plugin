import '../models/models.dart';

abstract class DeviceRepository {
  Future<bool> isDeviceRegistered();

  Stream<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  });

  Stream<Subscription?> subscription();

  Future<String> getDeviceID();

  Future<bool?> getIsKeyboardAdded();
}
