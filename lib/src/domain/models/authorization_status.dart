/// Status of the permissions
enum AuthorizationStatus {
  /// The user has not yet made a choice regarding the permissions
  notDetermined,

  /// The permission is restricted
  restricted,

  /// The permission is denied
  denied,

  /// The permission is authorized
  authorized,
}
