import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'user_provider.dart';

/// User Provider Implementation
class UserProviderImpl implements UserProvider {
  final MethodChannel _initMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/init',
  );
  final MethodChannel _basicInfoMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/basic_info',
  );
  final MethodChannel _passwordMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/get_password',
  );
  final MethodChannel _identityIdMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/get_identity_id',
  );

  final SDKMethodChannel _sdkMethodChannel;

  /// User Provider Implementation
  UserProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> init({
    required String apiKey,
    int? yearOfBirth,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  }) async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.init,
      methodChannel: _initMethodChannel,
      params: <String, dynamic>{
        'apiKey': apiKey,
        'age': yearOfBirth,
        'gender': gender?.id,
        'selfDeclaredHealthy': selfDeclaredHealthy,
        'identityId': identityId,
        'password': password,
      },
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
      methodChannel: _basicInfoMethodChannel,
    );
  }

  @override
  Future<String?> getPassword() {
    return _sdkMethodChannel.callMethodChannel<String?>(
      method: SupportedMethods.getPassword,
      methodChannel: _passwordMethodChannel,
    );
  }

  @override
  Future<String> getIdentityId() {
    return _sdkMethodChannel.callMethodChannel<String>(
      method: SupportedMethods.getIdentityId,
      methodChannel: _identityIdMethodChannel,
    );
  }
}
