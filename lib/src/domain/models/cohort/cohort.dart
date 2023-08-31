import 'package:json_annotation/json_annotation.dart';

part 'cohort.g.dart';

@JsonSerializable()
class Cohort {
  final String cohortId;
  final String? privacyPolicy;
  final String? cohortName;
  final String? dataPattern;

  //It is 1 if the device is allowed to withdraw,
  // if 0 only the cohort manager can withdraw the device
  final int canWithdraw;

  //Is app id permission necessary for this cohort
  final int? permAppId;

  //Is app id permission necessary for this cohort
  final int? permDrawOver;

  Cohort({
    required this.cohortId,
    required this.privacyPolicy,
    required this.cohortName,
    required this.dataPattern,
    required this.canWithdraw,
    required this.permAppId,
    required this.permDrawOver,
  });

  factory Cohort.fromJson(Map<String, dynamic> json) => _$CohortFromJson(json);

  Map<String, dynamic> toJson() => _$CohortToJson(this);
}
