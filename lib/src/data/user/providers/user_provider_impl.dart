import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../core/sdk_method_channel.dart';
import 'user_provider.dart';

class UserProviderImpl implements UserProvider {
  final _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/user',
  );

  final SDKMethodChannel _sdkMethodChannel;

  UserProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'init',
      eventChannel: _eventChannel,
      params: _buildInitParams(
        apiKey: apiKey,
        age: age,
        gender: gender,
        selfDeclaredHealthy: selfDeclaredHealthy,
      ),
    );
  }

  @override
  Future<bool> initAsync({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'initAsync',
      params: _buildInitParams(
        apiKey: apiKey,
        age: age,
        gender: gender,
        selfDeclaredHealthy: selfDeclaredHealthy,
      ),
    );
  }

  @override
  Future<bool> isInit() async {
    return _sdkMethodChannel.callMethodChannel<bool>(method: 'isInit');
  }

  @override
  Future<void> savePublicKey() async {
    _sdkMethodChannel.callMethodChannel(method: 'savePublicKey');
  }

  @override
  Future<void> setVerboseLevel(int verbose) async {
    _sdkMethodChannel.callMethodChannel(
      method: 'setVerboseLevel',
      params: <String, dynamic>{
        'verbose': verbose,
      },
    );
  }

  @override
  Stream<dynamic> validateToken({required String apiKey}) {
    return _sdkMethodChannel.callEventChannel(
      method: 'validateToken',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  @override
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) async {
    _sdkMethodChannel.callMethodChannel(
      method: 'updateBasicInfo',
      params: <String, dynamic>{
        'newYearOfBirth': newYearOfBirth,
        'newGender': newGender?.id,
        'newSelfDeclaredHealthy': newSelfDeclaredHealthy,
      },
    );
  }

  Map<String, dynamic> _buildInitParams({
    required String apiKey,
    required int? age,
    required Gender? gender,
    required bool? selfDeclaredHealthy,
  }) {
    return <String, dynamic>{
      "apiKey": apiKey,
      "age": age,
      "gender": gender?.id,
      "selfDeclaredHealthy": selfDeclaredHealthy,
    };
  }

  @override
  Future<String> getBasicInfo() {
    return _sdkMethodChannel.callMethodChannel<String>(method: 'getBasicInfo');
  }
}
