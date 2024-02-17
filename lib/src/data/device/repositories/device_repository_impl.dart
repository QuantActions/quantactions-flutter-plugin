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
    final String json = await _deviceProvider.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );

    return SubscriptionWithQuestionnaires.fromJson(jsonDecode(json));
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
    final String json = await _deviceProvider.getConnectedDevices();

    return jsonDecode(json);
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _deviceProvider.getIsKeyboardAdded();
  }

  @override
  Future<void> openBatteryOptimisationSettings() async {
    await _deviceProvider.openBatteryOptimisationSettings();
  }

  @override
  Future<KeyboardSettings> keyboardSettings() async {
    final String json = await _deviceProvider.getKeyboardSettings();

    return KeyboardSettings.fromJson(jsonDecode(json));
  }

  @override
  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  }) async {
    await _deviceProvider.updateKeyboardSettings(keyboardSettings: keyboardSettings);
  }

  @override
  Future<AuthorizationStatus> coreMotionAuthorizationStatus() async {
    final int index = await _deviceProvider.coreMotionAuthorizationStatus();

    switch (index) {
      case 1:
        return AuthorizationStatus.restricted;
      case 2:
        return AuthorizationStatus.denied;
      case 3:
        return AuthorizationStatus.authorized;
      default:
        return AuthorizationStatus.notDetermined;
    }
  }

  @override
  Future<bool> isHealthKitAuthorizationStatusDetermined() async {
    return _deviceProvider.isHealthKitAuthorizationStatusDetermined();
  }

  @override
  Future<bool> requestCoreMotionAuthorization() async {
    return _deviceProvider.requestCoreMotionAuthorization();
  }

  @override
  Future<bool> requestHealthKitAuthorization() async {
    return _deviceProvider.requestHealthKitAuthorization();
  }
}
