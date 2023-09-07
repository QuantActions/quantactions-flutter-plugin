import '../../../domain/domain.dart';

class CohortMapper {
  static List<Cohort> fromList(List<dynamic> list) {
    return list.map((dynamic map) => fromJson(map as Map<String, dynamic>)).toList();
  }

  static Cohort fromJson(Map<String, dynamic> map) {
    return Cohort(
      cohortId: map['cohortId'] as String,
      privacyPolicy: map['privacyPolicy'] as String,
      cohortName: map['cohortName'] as String,
      dataPattern: map['dataPattern'] as String,
      gpsResolution: map['gpsResolution'] as int,
      canWithdraw: map['canWithdraw'] as int,
      syncOnScreenOff: map['syncOnScreenOff'] as int?,
      perimeterCheck: map['perimeterCheck'] as int?,
      permAppId: map['permAppId'] as int?,
      permDrawOver: map['permDrawOver'] as int?,
      permLocation: map['permLocation'] as int?,
      permContact: map['permContact'] as int?,
    );
  }
}
