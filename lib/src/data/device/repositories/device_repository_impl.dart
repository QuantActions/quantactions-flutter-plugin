import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/device/subscriptions_mapper.dart';
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
  Future<List<Subscription>> getSubscriptions() async {
    final String? json = await _deviceProvider.getSubscriptions();
    
    if (json == null) return <Subscription>[];

    return SubscriptionsMapper.fromList(jsonDecode(json));
  }

  @override
  Future<String> getDeviceID() {
    return _deviceProvider.getDeviceID();
  }

  @override
  Future<List<String>> getConnectedDevices() async {
    return _deviceProvider.getConnectedDevices();
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _deviceProvider.getIsKeyboardAdded();
  }

  @override
  Future<void> openBatteryOptimisationSettings() async {
    await _deviceProvider.openBatteryOptimisationSettings();
  }
}
