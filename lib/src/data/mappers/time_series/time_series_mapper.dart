import 'dart:convert';

import '../../../domain/domain.dart';

/// TimeSeries Mapper
class TimeSeriesMapper<T> {
  /// List from a stream
  static Stream<TimeSeries<T>> fromStream<T>(Stream<dynamic> stream) {
    return stream
        .map((dynamic event) => TimeSeries<T>.fromJson(jsonDecode(event)));
  }
}
