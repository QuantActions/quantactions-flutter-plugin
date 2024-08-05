import 'dart:convert';

import '../../../domain/domain.dart';
import '../providers/user_provider.dart';

/// User Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider;

  /// User Repository Implementation constructor
  UserRepositoryImpl({
    required UserProvider userProvider,
  }) : _userProvider = userProvider;

  @override
  Future<bool> init({
    required String apiKey,
    int? yearOfBirth,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  }) async {
    return _userProvider.init(
      apiKey: apiKey,
      yearOfBirth: yearOfBirth,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
      identityId: identityId,
      password: password,
    );
  }

  @override
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) async {
    await _userProvider.updateBasicInfo(
      newYearOfBirth: newYearOfBirth,
      newGender: newGender,
      newSelfDeclaredHealthy: newSelfDeclaredHealthy,
    );
  }

  @override
  Future<BasicInfo> getBasicInfo() async {
    final String json = await _userProvider.getBasicInfo();

    return BasicInfo.fromJson(jsonDecode(json));
  }

  @override
  Future<String?> getPassword() async {
    return _userProvider.getPassword();
  }

  @override
  Future<String> getIdentityId() {
    return _userProvider.getIdentityId();
  }
}
