import '../models/models.dart';

abstract class UserRepository {
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

  Future<BasicInfo> getBasicInfo();
}
