import '../models/models.dart';

/// Repository for user utils
abstract class UserRepository {
  /// Initialize the sdk
  Future<bool> init({
    required String apiKey,
    int? yearOfBirth,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  });

  /// Update the basic info of the user
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  /// Get the basic info of the user
  Future<BasicInfo> getBasicInfo();

  /// Get the password of the user
  Future<String?> getPassword();

  /// Get the identity id of the user
  Future<String> getIdentityId();
}
