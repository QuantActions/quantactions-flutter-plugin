abstract class PermissionRepository {
  Future<bool> canDraw();

  Future<bool> canUsage();

  Future<void> openDrawSettings();

  Future<void> openUsageSettings();
}
