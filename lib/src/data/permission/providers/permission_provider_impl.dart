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
}
