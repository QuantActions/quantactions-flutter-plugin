import '../../../domain/domain.dart';

abstract class UserProvider {
  Future<bool> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  });

  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  Future<String> getBasicInfo();

  Future<String?> getPassword();

  Future<String> getIdentityId();
}
