import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/qa_response/qa_response_mapper.dart';
import '../providers/user_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider;

  UserRepositoryImpl({
    required UserProvider userProvider,
  }) : _userProvider = userProvider;

  @override
  Stream<QAResponse<String>> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    final Stream<dynamic> initStream = _userProvider.init(
      apiKey: apiKey,
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );

    return QAResponseMapper.fromStream<String>(initStream);
  }

  @override
  Future<void> savePublicKey() async {
    await _userProvider.savePublicKey();
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
}
