import '../../../domain/domain.dart';

abstract class UserProvider {
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

  Future<String> getBasicInfo();
}
