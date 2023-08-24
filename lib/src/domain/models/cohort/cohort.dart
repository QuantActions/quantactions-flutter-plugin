class Cohort {
  final String cohortId;
  final String? privacyPolicy;
  final String? cohortName;
  final String? dataPattern;
  final int gpsResolution;
  final int canWithdraw;
  final int? syncOnScreenOff;
  final int? perimeterCheck;
  final int? permAppId;
  final int? permDrawOver;
  final int? permLocation;
  final int? permContact;

  Cohort({
    required this.cohortId,
    required this.privacyPolicy,
    required this.cohortName,
    required this.dataPattern,
    required this.gpsResolution,
    required this.canWithdraw,
    required this.syncOnScreenOff,
    required this.perimeterCheck,
    required this.permAppId,
    required this.permDrawOver,
    required this.permLocation,
    required this.permContact,
  });
}
