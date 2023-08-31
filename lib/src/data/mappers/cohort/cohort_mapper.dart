import 'dart:convert';

import '../../../domain/domain.dart';

class CohortMapper {
  static Stream<List<Cohort>> listFromStream(Stream<dynamic> stream) {
    return stream.map((event) {
      return CohortMapper.fromList(jsonDecode(event));
    });
  }

  static List<Cohort> fromList(List<dynamic> list) {
    return list.map((cohort) => Cohort.fromJson(cohort)).toList();
  }
}
