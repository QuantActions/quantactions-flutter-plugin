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
  Future<bool> isInit() {
    return _userProvider.isInit();
  }

  @override
  Future<bool> initAsync({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _userProvider.initAsync(
      apiKey: apiKey,
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

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
  void savePublicKey() {
    _userProvider.savePublicKey();
  }

  @override
  void setVerboseLevel(int verbose) {
    _userProvider.setVerboseLevel(verbose);
  }

  @override
  Stream<QAResponse<String>> validateToken({
    required String apiKey,
  }) {
    final stream = _userProvider.validateToken(apiKey: apiKey);

    return QAResponseMapper.fromStream<String>(stream);
  }

  @override
  void updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) {
    _userProvider.updateBasicInfo(
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
