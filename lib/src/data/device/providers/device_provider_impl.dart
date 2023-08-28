import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../core/sdk_method_channel.dart';
import 'device_provider.dart';

class DeviceProviderImpl implements DeviceProvider {
  final _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/device',
  );

  final SDKMethodChannel _sdkMethodChannel;

  DeviceProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool?> isDeviceRegistered() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'isDeviceRegistered',
    );
  }

  @override
  Stream<dynamic> redeemVoucher({
    required String voucher,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'redeemVoucher',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'voucher': voucher,
      },
    );
  }

  @override
  Stream<dynamic> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'subscribeWithGooglePurchaseToken',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'purchaseToken': purchaseToken,
      },
    );
  }

  @override
  Stream<dynamic> subscribe({
    required String subscriptionIdOrCohortId,
  }) {
    return _sdkMethodChannel.callEventChannel(
      eventChannel: _eventChannel,
      method: 'subscribe',
      params: <String, dynamic>{
        'subscriptionIdOrCohortId': subscriptionIdOrCohortId,
      },
    );
  }

  @override
  Stream getSubscriptionId() {
    return _sdkMethodChannel.callEventChannel(
      eventChannel: _eventChannel,
      method: 'getSubscriptionId',
    );
  }

  @override
  Future<String?> getSubscriptionIdAsync() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: 'getSubscriptionIdAsync',
    );
  }

  @override
  Future retrieveBatteryOptimizationIntentForCurrentManufacturer() {
    return _sdkMethodChannel.callMethodChannel(
      method: 'retrieveBatteryOptimizationIntentForCurrentManufacturer',
    );
  }

  @override
  Future syncData() {
    return _sdkMethodChannel.callMethodChannel(
      method: 'syncData',
    );
  }
}
