import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'device_provider.dart';

class DeviceProviderImpl implements DeviceProvider {
  final EventChannel _getSubscriptionIdEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_subscription_id',
  );
  final EventChannel _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/device',
  );

  final SDKMethodChannel _sdkMethodChannel;

  DeviceProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> isDeviceRegistered() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.isDeviceRegistered,
    );
  }

  @override
  Stream<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  }) {
    return _sdkMethodChannel.callEventChannel(
      eventChannel: _eventChannel,
      method: SupportedMethods.subscribe,
      params: <String, dynamic>{
        'subscriptionIdOrCohortId': subscriptionIdOrCohortId,
      },
    );
  }

  @override
  Stream<dynamic> subscription() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.subscription,
      eventChannel: _getSubscriptionIdEventChannel,
    );
  }

  @override
  Future<String> syncData() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.syncData,
    );
  }

  @override
  Future<String> getDeviceID() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.getDeviceID,
    );
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _sdkMethodChannel.callMethodChannel<bool?>(
      method: SupportedMethods.getDeviceID,
    );
  }
}
