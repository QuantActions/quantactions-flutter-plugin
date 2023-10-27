import '../models/models.dart';

abstract class UserRepository {
  Future<bool> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  Future<void> savePublicKey();

  Future<BasicInfo> getBasicInfo();
}
