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
  Future<bool> isDeviceRegistered() {
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
  Stream<dynamic> getSubscriptionId() {
    return _sdkMethodChannel.callEventChannel(
      eventChannel: _eventChannel,
      method: 'getSubscriptionId',
    );
  }

  @override
  Future<String?> getSubscriptionIdAsync() {
    return _sdkMethodChannel.callMethodChannel(
      method: 'getSubscriptionIdAsync',
    );
  }

  @override
  Future<String> retrieveBatteryOptimizationIntentForCurrentManufacturer() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: 'retrieveBatteryOptimizationIntentForCurrentManufacturer',
    );
  }

  @override
  Future<String> syncData() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: 'syncData',
    );
  }

  @override
  Future<String> getDeviceID() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: 'getDeviceID',
    );
  }

  @override
  Future<String?> getFirebaseToken() async {
    return _sdkMethodChannel.callMethodChannel<String?>(
      method: 'getFirebaseToken',
    );
  }

  @override
  Future<bool> getIsTablet() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'getIsTablet',
    );
  }
}
