import 'dart:convert';

import '../../../domain/domain.dart';
import '../../error_handler/mapper_wrapper.dart';

class TimeSeriesMapper<T> {
  static Stream<TimeSeries<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream.map((dynamic event) {
      return MapperWrapper.handleErrors<TimeSeries<T>>(
        data: json,
        mapper: () => TimeSeries<T>.fromJson(jsonDecode(event)),
      );
    });
  }
}
