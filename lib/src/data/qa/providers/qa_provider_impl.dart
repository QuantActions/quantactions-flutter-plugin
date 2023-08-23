import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import 'qa_provider.dart';

class QAProviderImpl implements QAProvider {
  final SDKMethodChannel _sdkMethodChannel;

  QAProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'init',
      params: _buildInitParams(
        age: age,
        gender: gender,
        selfDeclaredHealthy: selfDeclaredHealthy,
      ),
    );
  }

  @override
  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'initAsync',
      params: _buildInitParams(
        age: age,
        gender: gender,
        selfDeclaredHealthy: selfDeclaredHealthy,
      ),
    );
  }

  @override
  Future<bool?> isDeviceRegistered() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'isDeviceRegistered',
    );
  }

  @override
  Future<bool?> isInit() async {
    return _sdkMethodChannel.callMethodChannel<bool>(method: 'isInit');
  }

  @override
  void savePublicKey() {
    _sdkMethodChannel.callMethodChannel(method: 'isInit');
  }

  Map<String, dynamic> _buildInitParams({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return <String, dynamic>{
      "age": age,
      "gender": gender?.id,
      "selfDeclaredHealthy": selfDeclaredHealthy,
    };
  }
}
