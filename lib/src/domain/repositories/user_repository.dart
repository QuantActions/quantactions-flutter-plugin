import '../models/models.dart';

abstract class UserRepository {
  Future<bool> isInit();

  Future<bool> initAsync({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

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

  Future<void> setVerboseLevel(int verbose);

  Stream<QAResponse<String>> validateToken({
    required String apiKey,
  });

  Future<BasicInfo> getBasicInfo();
}
