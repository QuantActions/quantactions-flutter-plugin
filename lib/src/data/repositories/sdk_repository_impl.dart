import 'package:qa_flutter_plugin/src/data/mappers/qa_response/qa_response_stream_mapper.dart';

import '../../domain/domain.dart';
import '../providers/sdk_method_channel.dart';

class SDKRepositoryImpl implements SDKRepository {
  final SDKMethodChannel _sdkMethodChannel;

  SDKRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool?> isInit() {
    return _sdkMethodChannel.isInit();
  }

  @override
  Future<bool?> isDeviceRegistered() {
    return _sdkMethodChannel.isDeviceRegistered();
  }

  @override
  Future<bool?> isDataCollectionRunning() {
    return _sdkMethodChannel.isDataCollectionRunning();
  }

  @override
  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkMethodChannel.initAsync(
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
    final initStream = _sdkMethodChannel.init(
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );

    return QAResponseStreamMapper.getString(initStream);
  }
}
