import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'basic_info.g.dart';

@JsonSerializable()
class BasicInfo {
  final int yearOfBirth;
  final Gender gender;
  final bool selfDeclaredHealthy;

  BasicInfo({
    required this.yearOfBirth,
    required this.gender,
    required this.selfDeclaredHealthy,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BasicInfoToJson(this);
}
