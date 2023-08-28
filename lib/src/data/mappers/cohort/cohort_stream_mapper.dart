import 'dart:convert';

import '../../../domain/domain.dart';
import 'cohort_mapper.dart';

class CohortStreamMapper {
  static Stream<List<Cohort>> getList(Stream<dynamic> stream) {
    return stream.map((event) {
      return CohortMapper.fromList(jsonDecode(event));
    });
  }
}
