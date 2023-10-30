import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'user_provider.dart';

class UserProviderImpl implements UserProvider {
  final MethodChannel _initMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/init',
  );
  final MethodChannel _basicInfoMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/basic_info',
  );

  final SDKMethodChannel _sdkMethodChannel;

  UserProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.init,
      methodChannel: _initMethodChannel,
      params: _buildInitParams(
        apiKey: apiKey,
        age: age,
        gender: gender,
        selfDeclaredHealthy: selfDeclaredHealthy,
      ),
    );
  }

  @override
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.updateBasicInfo,
      methodChannel: _basicInfoMethodChannel,
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
      methodChannel: _basicInfoMethodChannel
    );
  }

  Map<String, dynamic> _buildInitParams({
    required String apiKey,
    required int? age,
    required Gender? gender,
    required bool? selfDeclaredHealthy,
  }) {
    return <String, dynamic>{
      'apiKey': apiKey,
      'age': age,
      'gender': gender?.id,
      'selfDeclaredHealthy': selfDeclaredHealthy,
    };
  }
}
