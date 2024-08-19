import 'package:json_annotation/json_annotation.dart';

part 'cohort.g.dart';

/// Cohort Model. Contains information about a cohort.
@JsonSerializable()
class Cohort {
  /// Cohort ID
  final String cohortId;

  /// Privacy policy, a text that explains the privacy policy of the cohort
  final String? privacyPolicy;

  /// Cohort name
  final String? cohortName;

  /// Data pattern (ignored)
  final String? dataPattern;

  /// It is 1 if the device is allowed to withdraw,
  /// if 0 only the cohort manager can withdraw the device
  final int canWithdraw;

  /// Is app id permission necessary for this cohort
  final int? permAppId;

  /// Is app id permission necessary for this cohort
  final int? permDrawOver;

  /// Cohort Model constructor
  Cohort({
    required this.cohortId,
    required this.privacyPolicy,
    required this.cohortName,
    required this.dataPattern,
    required this.canWithdraw,
    required this.permAppId,
    required this.permDrawOver,
  });

  /// Converts a [Map] to an [Cohort] instance.
  factory Cohort.fromJson(Map<String, dynamic> json) => _$CohortFromJson(json);

  /// Converts an [Cohort] instance to a [Map].
  Map<String, dynamic> toJson() => _$CohortToJson(this);
}
