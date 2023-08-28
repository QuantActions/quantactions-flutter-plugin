import '../../core/sdk_method_channel.dart';
import 'permission_provider.dart';

class PermissionProviderImpl implements PermissionProvider {
  final SDKMethodChannel _sdkMethodChannel;

  PermissionProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> canDraw() async {
    return _sdkMethodChannel.callMethodChannel<bool>(method: 'canDraw');
  }

  @override
  Future<bool> canUsage() async {
    return _sdkMethodChannel.callMethodChannel<bool>(method: 'canUsage');
  }

  @override
  Future<int> requestOverlayPermission() {
    return _sdkMethodChannel.callMethodChannel<int>(
      method: 'requestOverlayPermission',
    );
  }

  @override
  Future<int> requestUsagePermission() {
    return _sdkMethodChannel.callMethodChannel<int>(
      method: 'requestUsagePermission',
    );
  }
}
