import '../../../domain/domain.dart';
import '../screen_time_aggregate/screen_time_aggregate_mapper.dart';
import '../sleep_summary/sleep_summary_mapper.dart';
import '../trend_holder/trend_holder_mapper.dart';

class TimeSeriesMapper {
  static const String _timestamps = 'timestamps';
  static const String _values = 'values';
  static const String _confidenceIntervalLow = 'confidenceIntervalLow';
  static const String _confidenceIntervalHigh = 'confidenceIntervalHigh';
  static const String _confidence = 'confidence';

  static TimeSeries<double> fromJsonDouble(Map<String, dynamic> json) {
    return TimeSeries<double>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .cast<double>()
          .map<double>((dynamic item) => item == null ? double.nan : item as double)
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<double>((dynamic item) => item == null ? double.nan : item as double)
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<double>((dynamic item) => item == null ? double.nan : item as double)
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<TrendHolder> fromJsonTrendHolderTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<TrendHolder>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values].map<TrendHolder>(TrendHolderMapper.fromJson).toList(),
      confidenceIntervalLow:
          json[_confidenceIntervalLow].map<TrendHolder>(TrendHolderMapper.fromJson).toList(),
      confidenceIntervalHigh:
          json[_confidenceIntervalHigh].map<TrendHolder>(TrendHolderMapper.fromJson).toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<SleepSummary> fromJsonSleepSummaryTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<SleepSummary>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values].map<SleepSummary>(SleepSummaryMapper.fromJson).toList(),
      confidenceIntervalLow:
          json[_confidenceIntervalLow].map<SleepSummary>(SleepSummaryMapper.fromJson).toList(),
      confidenceIntervalHigh:
          json[_confidenceIntervalHigh].map<SleepSummary>(SleepSummaryMapper.fromJson).toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values].map<ScreenTimeAggregate>(ScreenTimeAggregateMapper.fromJson).toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<ScreenTimeAggregate>(ScreenTimeAggregateMapper.fromJson)
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<ScreenTimeAggregate>(ScreenTimeAggregateMapper.fromJson)
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static List<DateTime> _getTimestamps(dynamic data) {
    return data
        .map<DateTime>(
          (dynamic item) => DateTime.parse((item as String).split('[').first).toLocal(),
        )
        .toList();
  }
}
