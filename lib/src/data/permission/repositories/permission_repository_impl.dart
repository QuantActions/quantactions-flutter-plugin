import '../../../domain/domain.dart';
import '../providers/permission_provider.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionProvider _permissionProvider;

  PermissionRepositoryImpl({
    required PermissionProvider permissionProvider,
  }) : _permissionProvider = permissionProvider;

  @override
  Future<bool> canDraw() {
    return _permissionProvider.canDraw();
  }

  @override
  Future<bool> canUsage() {
    return _permissionProvider.canUsage();
  }
}
