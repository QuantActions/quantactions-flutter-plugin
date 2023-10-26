import '../models/models.dart';

abstract class UserRepository {
  Stream<QAResponse<String>> init({
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
