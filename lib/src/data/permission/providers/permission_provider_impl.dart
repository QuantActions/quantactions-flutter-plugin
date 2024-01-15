import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'permission_provider.dart';

class PermissionProviderImpl implements PermissionProvider {
  final SDKMethodChannel _sdkMethodChannel;

  final MethodChannel _canDrawMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/can_draw',
  );

  final MethodChannel _canUsageMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/can_usage',
  );

  final MethodChannel _requestOverlayPermissionMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/request_overlay_permission',
  );

  final MethodChannel _requestUsagePermissionMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/request_usage_permission',
  );

  PermissionProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> canDraw() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.canDraw,
      methodChannel: _canDrawMethodChannel,
    );
  }

  @override
  Future<bool> canUsage() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.canUsage,
      methodChannel: _canUsageMethodChannel,
    );
  }

  @override
  Future<void> openDrawSettings() async {
    await _sdkMethodChannel.callMethodChannel<int>(
      method: SupportedMethods.requestOverlayPermission,
      methodChannel: _requestOverlayPermissionMethodChannel,
    );
  }

  @override
  Future<void> openUsageSettings() async {
    await _sdkMethodChannel.callMethodChannel<int>(
      method: SupportedMethods.requestUsagePermission,
      methodChannel: _requestUsagePermissionMethodChannel,
    );
  }
}
