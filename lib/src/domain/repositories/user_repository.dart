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

  void updateBasicInfo({
    required int newYearOfBirth,
    required Gender newGender,
    required bool newSelfDeclaredHealthy,
  });

  void savePublicKey();

  void setVerboseLevel(int verbose);

  Stream<QAResponse<String>> validateToken({
    required String apiKey,
  });

  Future<BasicInfo> getBasicInfo();
}
