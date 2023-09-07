import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'device_provider.dart';

class DeviceProviderImpl implements DeviceProvider {
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
  Stream<dynamic> redeemVoucher({
    required String voucher,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.redeemVoucher,
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
      method: SupportedMethods.subscribeWithGooglePurchaseToken,
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
      method: SupportedMethods.subscribe,
      params: <String, dynamic>{
        'subscriptionIdOrCohortId': subscriptionIdOrCohortId,
      },
    );
  }

  @override
  Stream<dynamic> getSubscriptionId() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getSubscriptionId,
      eventChannel: _eventChannel,
    );
  }

  @override
  Future<String?> getSubscriptionIdAsync() {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.getSubscriptionIdAsync,
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
  Future<String?> getFirebaseToken() async {
    return _sdkMethodChannel.callMethodChannel<String?>(
      method: SupportedMethods.getFirebaseToken,
    );
  }

  @override
  Future<bool> getIsTablet() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.getIsTablet,
    );
  }
}
