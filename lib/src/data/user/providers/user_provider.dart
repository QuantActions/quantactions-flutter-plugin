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

  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  Future<void> savePublicKey();

  Future<void> setVerboseLevel(int verbose);

  Stream<dynamic> validateToken({
    required String apiKey,
  });

  Future<String> getBasicInfo();
}
