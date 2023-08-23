abstract class PermissionProvider {
  Future<bool?> canDraw();

  Future<bool?> canUsage();
}
