import 'package:freezed_annotation/freezed_annotation.dart';

part 'cohort.g.dart';

part 'cohort.freezed.dart';

@freezed
class Cohort with _$Cohort {
  factory Cohort({
    required String cohortId,
    required String? privacyPolicy,
    required String? cohortName,
    required String? dataPattern,
    //It is 1 if the device is allowed to withdraw,
    // if 0 only the cohort manager can withdraw the device
    required int canWithdraw,
    //Is app id permission necessary for this cohort
    required int? permAppId,
    //Is app id permission necessary for this cohort
    required int? permDrawOver,
  }) = _Cohort;

  factory Cohort.fromJson(Map<String, dynamic> json) => _$CohortFromJson(json);
}
