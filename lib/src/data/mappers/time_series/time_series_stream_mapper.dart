import 'dart:convert';

import '../../../domain/domain.dart';
import 'time_series_mapper.dart';

class TimeSeriesStreamMapper {
  static Stream<TimeSeries<dynamic>> getDouble(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => TimeSeriesMapper.fromJsonDouble(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<SleepSummary>> getSleepSummary(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (dynamic event) => TimeSeriesMapper.fromJsonSleepSummaryTimeSeries(
        jsonDecode(event),
      ),
    );
  }

  static Stream<TimeSeries<ScreenTimeAggregate>> getScreenTimeAggregate(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (dynamic event) => TimeSeriesMapper.fromJsonScreenTimeAggregateTimeSeries(
        jsonDecode(event),
      ),
    );
  }

  static Stream<TimeSeries<TrendHolder>> getTrendHolder(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (dynamic event) => TimeSeriesMapper.fromJsonTrendHolderTimeSeries(
        jsonDecode(event),
      ),
    );
  }
}
