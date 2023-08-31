import 'dart:convert';

import '../../../domain/domain.dart';

class QAResponseMapper {
  static Stream<QAResponse<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream.map(
      (event) => QAResponse<T>.fromJson(jsonDecode(event)),
    );
  }

  static List<QAResponse<T>> fromList<T>(List<dynamic> list) {
    return list.map((json) => QAResponse<T>.fromJson(json)).toList();
  }
}
