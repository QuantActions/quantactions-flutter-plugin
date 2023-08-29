import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
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
      method: SupportedMethods.init,
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
      method: SupportedMethods.initAsync,
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
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.isInit,
    );
  }

  @override
  void savePublicKey() {
    _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.savePublicKey,
    );
  }

  @override
  void setVerboseLevel(int verbose) {
    _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.setVerboseLevel,
      params: <String, dynamic>{
        'verbose': verbose,
      },
    );
  }

  @override
  Stream<dynamic> validateToken({
    required String apiKey,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.validateToken,
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  @override
  void updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) {
    _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.updateBasicInfo,
      params: <String, dynamic>{
        'newYearOfBirth': newYearOfBirth,
        'newGender': newGender?.id,
        'newSelfDeclaredHealthy': newSelfDeclaredHealthy,
      },
    );
  }

  @override
  Future<String> getBasicInfo() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.getBasicInfo,
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
}
