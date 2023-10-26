import 'dart:convert';

import '../../../domain/domain.dart';
import '../../error_handler/mapper_wrapper.dart';

class QAResponseMapper {
  static Stream<QAResponse<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => QAResponse<T>.fromJson(jsonDecode(event)),
    );
  }

  static List<QAResponse<T>> fromList<T>(List<dynamic> list) {
    return list.map((dynamic json) {
      return MapperWrapper.handleErrors<QAResponse<T>>(
        data: json,
        mapper: () => QAResponse<T>.fromJson(json as Map<String, dynamic>),
      );
    }).toList();
  }
}
