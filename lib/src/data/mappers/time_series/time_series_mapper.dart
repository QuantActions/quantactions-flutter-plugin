import 'dart:convert';

import '../../../domain/domain.dart';

class TimeSeriesMapper<T> {
  static Stream<TimeSeries<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream.map(
      (event) => TimeSeries<T>.fromJson(jsonDecode(event)),
    );
  }
}
