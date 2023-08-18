import 'package:qa_flutter_plugin/src/data/mappers/screen_time_aggregate/screen_time_aggregate_mapper.dart';
import 'package:qa_flutter_plugin/src/data/mappers/trend_holder/tremd_holder_mapper.dart';

import '../../../domain/domain.dart';
import '../sleep_summary/sleep_summary_mapper.dart';

class TimeSeriesMapper {
  static TimeSeries<double> fromJson(Map<String, dynamic> json) {
    return TimeSeries<double>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
              (e) => DateTime.parse((e as String).split('[').first).toLocal())
          .toList(),
      values: json['values']
          .cast<double>()
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<TrendHolder> fromJsonTrendTimeSeries(
      Map<String, dynamic> json) {
    return TimeSeries<TrendHolder>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
              (e) => DateTime.parse((e as String).split('[').first).toLocal())
          .toList(),
      values: json['values']
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<SleepSummary> fromJsonSleepSummaryTimeSeries(
      Map<String, dynamic> json) {
    return TimeSeries<SleepSummary>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
              (e) => DateTime.parse((e as String).split('[').first).toLocal())
          .toList(),
      values: json['values']
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(
      Map<String, dynamic> json) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
              (e) => DateTime.parse((e as String).split('[').first).toLocal())
          .toList(),
      values: json['values']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }
}
