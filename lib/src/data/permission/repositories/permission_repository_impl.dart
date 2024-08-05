import '../../../domain/domain.dart';
import '../providers/permission_provider.dart';

/// Permission Repository Implementation
class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionProvider _permissionProvider;

  /// Permission Repository Implementation constructor
  PermissionRepositoryImpl({
    required PermissionProvider permissionProvider,
  }) : _permissionProvider = permissionProvider;

  @override
  Future<bool> canActivity() {
    return _permissionProvider.canActivity();
  }

  @override
  Future<bool> canDraw() {
    return _permissionProvider.canDraw();
  }

  @override
  Future<bool> canUsage() {
    return _permissionProvider.canUsage();
  }

  @override
  Future<bool> openDrawSettings() {
    return _permissionProvider.openDrawSettings();
  }

  @override
  Future<bool> openUsageSettings() {
    return _permissionProvider.openUsageSettings();
  }
}
