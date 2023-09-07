import 'package:collection/collection.dart';
import '../../../domain/domain.dart';

class BasicInfoMapper {
  static BasicInfo fromJson(Map<String, dynamic> map) {
    return BasicInfo(
      yearOfBirth: map['yearOfBirth'] as int,
      gender: Gender.values.firstWhereOrNull(
            (Gender element) => element.id == (map['gender'] as String).toLowerCase(),
          ) ??
          Gender.unknown,
      selfDeclaredHealthy: map['selfDeclaredHealthy'] as bool,
    );
  }
}
