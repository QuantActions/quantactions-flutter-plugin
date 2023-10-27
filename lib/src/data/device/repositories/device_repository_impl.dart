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
  Stream<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  }) {
    final Stream<dynamic> stream = _deviceProvider.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );

    return stream.map(
      (dynamic event) => SubscriptionWithQuestionnaires.fromJson(
        jsonDecode(event),
      ),
    );
  }

  @override
  Stream<Subscription?> subscription() {
    final Stream<dynamic> stream = _deviceProvider.subscription();

    return stream.map(
      (dynamic event) => Subscription.fromJson(jsonDecode(event)),
    );
  }

  @override
  Future<String> syncData() {
    return _deviceProvider.syncData();
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
