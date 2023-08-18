import 'package:qa_flutter_plugin/src/data/mappers/screen_time_aggregate/screen_time_aggregate_mapper.dart';
import 'package:qa_flutter_plugin/src/data/mappers/trend_holder/tremd_holder_mapper.dart';

import '../../../domain/domain.dart';
import '../sleep_summary/sleep_summary_mapper.dart';

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
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<TrendHolder> fromJsonTrendHolderTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<TrendHolder>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<SleepSummary> fromJsonSleepSummaryTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<SleepSummary>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static List<DateTime> _getTimestamps(dynamic data) {
    return data
        .map<DateTime>(
          (e) => DateTime.parse((e as String).split('[').first).toLocal(),
        )
        .toList();
  }
}
