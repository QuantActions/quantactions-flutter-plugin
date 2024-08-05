/// Repository for permission
abstract class PermissionRepository {
  /// Check if the app has permission to access the activity recognition API (necessary for data collection).
  Future<bool> canActivity();

  /// Check if the app has permission to draw over other apps (necessary for data collection)
  Future<bool> canDraw();

  /// Check if the app has permission to access the usage stats API (necessary for data collection).
  Future<bool> canUsage();

  /// Open the settings page to allow the draw over permission.
  Future<bool> openDrawSettings();

  /// Open the settings page to allow the usage access permission.
  Future<bool> openUsageSettings();
}
