import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'basic_info.g.dart';

@JsonSerializable()

/// Basic Info Model. Contains basic information about the user.
class BasicInfo {
  /// Year of birth
  final int yearOfBirth;
  @JsonKey(
    fromJson: _genderFromJson,
    toJson: _genderToJson,
  )

  /// Gender of the user
  final Gender gender;

  /// Indicates if the user feels they are generally healthy
  final bool selfDeclaredHealthy;

  /// Basic Info Model constructor
  BasicInfo({
    required this.yearOfBirth,
    required this.gender,
    required this.selfDeclaredHealthy,
  });

  /// Converts a [Map] to an [BasicInfo] instance.
  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);

  /// Converts an [BasicInfo] instance to a [Map].
  Map<String, dynamic> toJson() => _$BasicInfoToJson(this);

  static String _genderToJson(Gender gender) => gender.id;

  static Gender _genderFromJson(String gender) =>
      switch (gender.toUpperCase()) {
        'MALE' => Gender.male,
        'FEMALE' => Gender.female,
        'OTHER' => Gender.other,
        _ => Gender.unknown,
      };
}
