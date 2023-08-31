import 'dart:convert';

import '../../../domain/domain.dart';

class QAResponseStreamMapper {
  static Stream<QAResponse<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream.map(
      (event) => QAResponse<T>.fromJson(jsonDecode(event)),
    );
  }
}
