import '../../../domain/domain.dart';

abstract class QAProvider {
  Future<bool?> isInit();

  Future<bool?> isDeviceRegistered();

  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  Stream<dynamic> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  });

  void savePublicKey();
}
