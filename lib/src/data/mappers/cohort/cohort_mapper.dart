import 'dart:convert';

import '../../../domain/domain.dart';

class CohortMapper {
  static Stream<List<Cohort>> listFromStream(Stream<dynamic> stream) {
    return stream.map((dynamic event) {
      return CohortMapper.fromList(jsonDecode(event));
    });
  }

  static List<Cohort> fromList(List<dynamic> list) {
    return list.map((dynamic cohort) => Cohort.fromJson(cohort as Map<String, dynamic>)).toList();
  }
}
