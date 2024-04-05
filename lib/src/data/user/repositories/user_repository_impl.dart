import 'dart:convert';

import '../../../domain/domain.dart';
import '../providers/user_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider;

  UserRepositoryImpl({
    required UserProvider userProvider,
  }) : _userProvider = userProvider;

  @override
  Future<bool> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  }) async {
    return _userProvider.init(
      apiKey: apiKey,
      age: age,
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
    print("these are basic infos");
    print(json);

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
