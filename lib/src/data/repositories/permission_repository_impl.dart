import '../../domain/domain.dart';
import '../providers/sdk_method_channel.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final SDKMethodChannel _sdkMethodChannel;

  PermissionRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool?> canDraw() {
    return _sdkMethodChannel.canDraw();
  }

  @override
  Future<bool?> canUsage()  {
    return _sdkMethodChannel.canUsage();
  }
}
