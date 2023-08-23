import '../models/models.dart';

abstract class QARepository {
  Future<bool?> isInit();

  Future<bool?> isDeviceRegistered();

  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  Stream<QAResponse<String>> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  void savePublicKey();
}
