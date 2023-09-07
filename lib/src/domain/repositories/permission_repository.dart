abstract class PermissionRepository {
  Future<bool> canDraw();

  Future<bool> canUsage();
}
