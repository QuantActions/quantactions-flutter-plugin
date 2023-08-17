import 'dart:convert';

import '../../domain/domain.dart';
import 'time_series/time_series_mapper.dart';

class TimeSeriesStreamMapper {
  static Stream<TimeSeries<dynamic>> getDefault(Stream<dynamic> stream) {
    return stream.map((event) => TimeSeriesMapper.fromJson(jsonDecode(event)));
  }

  static Stream<TimeSeries<TrendHolder>> getTheWave(Stream<dynamic> stream) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonTrendTimeSeries(
        jsonDecode(event),
      ),
    );
  }

  static Stream<TimeSeries<SleepSummary>> getSleepSummary(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonSleepSummaryTimeSeries(
        jsonDecode(event),
      ),
    );
  }

  static Stream<TimeSeries<ScreenTimeAggregate>> getScreenTimeAggregate(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonScreenTimeAggregateTimeSeries(
        jsonDecode(event),
      ),
    );
  }

  static Stream<TimeSeries<double>> getActionSpeed(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<double>> getCognitiveFitness(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<double>> getScreenScope(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<double>> getSocialEngagement(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<double>> getSocialTap(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<double>> getTypingSpeed(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJson(jsonDecode(event)),
    );
  }
}
