import 'dart:ffi';

import 'package:flutter/services.dart';

import '../../../domain/models/keyboard_settings/keyboard_settings.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'device_provider.dart';

class DeviceProviderImpl implements DeviceProvider {
  final MethodChannel _getSubscriptionsMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/subscriptions',
  );
  final MethodChannel _isDeviceRegisteredMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/is_device_registered',
  );
  final MethodChannel _deviceIDMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/device_id',
  );
  final MethodChannel _lastTapsMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/last_taps',
  );
  final MethodChannel _subscribeMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/subscribe',
  );
  final MethodChannel _connectedDevicesMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/get_connected_devices',
  );
  final MethodChannel _batteryOptimisationMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/open_battery_optimisation_settings',
  );
  final MethodChannel _isKeyboardAddedMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/is_keyboard_added',
  );
  final MethodChannel _keyboardSettingsMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/keyboard_settings',
  );
  final MethodChannel _updateKeyboardSettingsMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/update_keyboard_settings',
  );
  final MethodChannel _updateFCMTokenMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/update_fcm_token',
  );
  final MethodChannel _coreMotionAuthorizationStatusMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/core_motion_authorization_status',
  );
  final MethodChannel _isHealthKitAuthorizationStatusDeterminedMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/is_health_kit_authorization_status_determined',
  );
  final MethodChannel _requestCoreMotionAuthorizationMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/request_core_motion_authorization',
  );
  final MethodChannel _requestHealthKitAuthorizationMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/request_health_kit_authorization',
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
  Future<String> subscribe({
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
  Future<dynamic> getSubscriptions() async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.subscriptions,
      methodChannel: _getSubscriptionsMethodChannel,
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
  Future<int> getLastTaps({required int backwardDays}) {
    return _sdkMethodChannel.callMethodChannel<int>(
      method: SupportedMethods.getLastTaps,
      methodChannel: _lastTapsMethodChannel,
      params: <String, dynamic>{
        'backwardDays': backwardDays,
      },
    );
  }

  @override
  Future<String> getConnectedDevices() async {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.getConnectedDevices,
      methodChannel: _connectedDevicesMethodChannel,
    );
  }

  @override
  Future<bool?> getIsKeyboardAdded() {
    return _sdkMethodChannel.callMethodChannel<bool?>(
      method: SupportedMethods.getIsKeyboardAdded,
      methodChannel: _isKeyboardAddedMethodChannel,
    );
  }

  @override
  Future<void> openBatteryOptimisationSettings() {
    return _sdkMethodChannel.callMethodChannel<void>(
      method: SupportedMethods.openBatteryOptimisationSettings,
      methodChannel: _batteryOptimisationMethodChannel,
    );
  }

  @override
  Future<String> getKeyboardSettings() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.keyboardSettings,
      methodChannel: _keyboardSettingsMethodChannel,
    );
  }

  @override
  Future<void> updateKeyboardSettings({required KeyboardSettings keyboardSettings}) {
    return _sdkMethodChannel.callMethodChannel<void>(
      method: SupportedMethods.updateKeyboardSettings,
      methodChannel: _updateKeyboardSettingsMethodChannel,
      params: keyboardSettings.toJson(),
    );
  }

  @override
  Future<void> updateFCMToken({required String token}) {

    return _sdkMethodChannel.callMethodChannel<void>(
      method: SupportedMethods.updateFCMToken,
      methodChannel: _updateFCMTokenMethodChannel,
      params: <String, dynamic>{
        'token': token,
      },
    );
  }

  @override
  Future<int> coreMotionAuthorizationStatus() {
    return _sdkMethodChannel.callMethodChannel<int>(
      method: SupportedMethods.coreMotionAuthorizationStatus,
      methodChannel: _coreMotionAuthorizationStatusMethodChannel,
    );
  }

  @override
  Future<bool> isHealthKitAuthorizationStatusDetermined() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.isHealthKitAuthorizationStatusDetermined,
      methodChannel: _isHealthKitAuthorizationStatusDeterminedMethodChannel,
    );
  }

  @override
  Future<bool> requestCoreMotionAuthorization() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.requestCoreMotionAuthorization,
      methodChannel: _requestCoreMotionAuthorizationMethodChannel,
    );
  }

  @override
  Future<bool> requestHealthKitAuthorization() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.requestHealthKitAuthorization,
      methodChannel: _requestHealthKitAuthorizationMethodChannel,
    );
  }
}
