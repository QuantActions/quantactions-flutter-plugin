import 'dart:convert';

import '../../../domain/domain.dart';
import '../providers/device_provider.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceProvider _deviceProvider;

  DeviceRepositoryImpl({
    required DeviceProvider deviceProvider,
  }) : _deviceProvider = deviceProvider;

  @override
  Future<bool> isDeviceRegistered() {
    return _deviceProvider.isDeviceRegistered();
  }

  @override
  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  }) async {
    final Map<String, dynamic> map = await _deviceProvider.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );

    return SubscriptionWithQuestionnaires.fromJson(map);
  }

  @override
  Future<Subscription?> getSubscription() async {
    final String? json = await _deviceProvider.getSubscription();

    if (json == null) return null;

    return Subscription.fromJson(jsonDecode(json));
  }

  @override
  Future<String> getDeviceID() {
    return _deviceProvider.getDeviceID();
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _deviceProvider.getIsKeyboardAdded();
  }
}
