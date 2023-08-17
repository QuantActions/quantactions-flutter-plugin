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

  static Stream<TimeSeries<ActionSpeed>> getActionSpeed(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonActionSpeed(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<CognitiveFitness>> getCognitiveFitness(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonCognitiveFitness(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<ScreenScope>> getScreenScope(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonScreenScope(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<SocialEngagement>> getSocialEngagement(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonSocialEngagement(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<SocialTap>> getSocialTap(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonSocialTap(jsonDecode(event)),
    );
  }

  static Stream<TimeSeries<TypingSpeed>> getTypingSpeed(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => TimeSeriesMapper.fromJsonTypingSpeed(jsonDecode(event)),
    );
  }
}
