import '../../../domain/domain.dart';

class CohortMapper {
  static List<Cohort> fromList(List<dynamic> list) {
    return list.map((cohort) => Cohort.fromJson(cohort)).toList();
  }
}
