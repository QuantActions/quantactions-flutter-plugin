import '../models/models.dart';

abstract class SDKRepository {
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
}
