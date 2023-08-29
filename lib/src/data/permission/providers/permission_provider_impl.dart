import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'permission_provider.dart';

class PermissionProviderImpl implements PermissionProvider {
  final SDKMethodChannel _sdkMethodChannel;

  PermissionProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> canDraw() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.canDraw,
    );
  }

  @override
  Future<bool> canUsage() async {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.canUsage,
    );
  }
}
