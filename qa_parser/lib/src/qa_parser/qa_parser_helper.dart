part of 'qa_parser.dart';

class _QAParserImplHelper {
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
}
