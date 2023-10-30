import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'device_provider.dart';

class DeviceProviderImpl implements DeviceProvider {
  final MethodChannel _getSubscriptionMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/subscription',
  );
  final MethodChannel _isDeviceRegisteredMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/is_device_registered',
  );
  final MethodChannel _deviceIDMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/device_id',
  );
  final MethodChannel _subscribeMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/subscribe',
  );

  final SDKMethodChannel _sdkMethodChannel;

  DeviceProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> isDeviceRegistered() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.isDeviceRegistered,
      methodChannel: _isDeviceRegisteredMethodChannel,
    );
  }

  @override
  Future<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  }) async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.subscribe,
      methodChannel: _subscribeMethodChannel,
      params: <String, dynamic>{
        'subscriptionIdOrCohortId': subscriptionIdOrCohortId,
      },
    );
  }

  @override
  Future<dynamic> getSubscription() async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.subscription,
      methodChannel: _getSubscriptionMethodChannel,
    );
  }

  @override
  Future<String> getDeviceID() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.getDeviceID,
      methodChannel: _deviceIDMethodChannel,
    );
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _sdkMethodChannel.callMethodChannel<bool?>(
      method: SupportedMethods.getDeviceID,
    );
  }
}
