import '../gender/gender.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_info.g.dart';

part 'basic_info.freezed.dart';

@freezed
class BasicInfo with _$BasicInfo {
  factory BasicInfo({
    required int yearOfBirth,
    required Gender gender,
    required bool selfDeclaredHealthy,
  }) = _BasicInfo;

  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);
}
