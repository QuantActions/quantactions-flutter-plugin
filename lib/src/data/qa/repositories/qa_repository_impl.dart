import '../../../domain/domain.dart';
import '../../mappers/qa_response/qa_response_stream_mapper.dart';
import '../providers/qa_provider.dart';

class QARepositoryImpl implements QARepository {
  final QAProvider _qaProvider;

  QARepositoryImpl({
    required QAProvider qaProvider,
  }) : _qaProvider = qaProvider;

  @override
  Future<bool?> isInit() {
    return _qaProvider.isInit();
  }

  @override
  Future<bool?> isDeviceRegistered() {
    return _qaProvider.isDeviceRegistered();
  }

  @override
  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _qaProvider.initAsync(
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

  @override
  Stream<QAResponse<String>> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    final Stream<dynamic> initStream = _qaProvider.init(
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );

    return QAResponseStreamMapper.getString(initStream);
  }

  @override
  void savePublicKey() {
    _qaProvider.savePublicKey();
  }
}
