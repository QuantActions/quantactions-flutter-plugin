import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'user_provider.dart';

class UserProviderImpl implements UserProvider {
  final EventChannel _eventChannel = const EventChannel(
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
  Future<void> savePublicKey() async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.savePublicKey,
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
      'apiKey': apiKey,
      'age': age,
      'gender': gender?.id,
      'selfDeclaredHealthy': selfDeclaredHealthy,
    };
  }
}
