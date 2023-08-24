abstract class PermissionRepository {
  Future<bool?> canDraw();

  Future<bool?> canUsage();

  Future<int?> requestOverlayPermission();

  Future<int?> requestUsagePermission();
}
