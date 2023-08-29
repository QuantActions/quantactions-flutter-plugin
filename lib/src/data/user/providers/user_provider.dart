import '../../../domain/domain.dart';

abstract class UserProvider {
  Future<bool> isInit();

  Future<bool> initAsync({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  Stream<dynamic> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  void updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  void savePublicKey();

  void setVerboseLevel(int verbose);

  Stream<dynamic> validateToken({
    required String apiKey,
  });

  Future<String> getBasicInfo();
}
