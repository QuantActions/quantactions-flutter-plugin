abstract class PermissionProvider {
  Future<bool> canActivity();

  Future<bool> canDraw();

  Future<bool> canUsage();

  Future<bool> openDrawSettings();

  Future<bool> openUsageSettings();
}
