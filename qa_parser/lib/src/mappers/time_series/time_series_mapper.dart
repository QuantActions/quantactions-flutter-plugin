import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../trend_holder/trend_holder_mapper.dart';

class TimeSeriesMapper<T> {
  static TimeSeries<double> fromJson(Map<String, dynamic> json) {
    debugPrint(json.keys.toString());

    return TimeSeries<double>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
            (e) => DateTime.parse((e as String).split('[').first).toLocal(),
          )
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
    Map<String, dynamic> json,
  ) {
    return TimeSeries<TrendHolder>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
            (e) => DateTime.parse((e as String).split('[').first).toLocal(),
          )
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
    Map<String, dynamic> json,
  ) {
    return TimeSeries<SleepSummary>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
            (e) => DateTime.parse((e as String).split('[').first).toLocal(),
          )
          .toList(),
      values: json['values']
          .map<SleepSummary>((e) => SleepSummary.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<SleepSummary>((e) => SleepSummary.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<SleepSummary>((e) => SleepSummary.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: json['timestamps']
          .cast<String>()
          .map<DateTime>(
            (e) => DateTime.parse((e as String).split('[').first).toLocal(),
          )
          .toList(),
      values: json['values']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonSleepScore(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: json['sleepScore']
          .cast<String>()
          .map<DateTime>(
            (e) => DateTime.parse((e as String).split('[').first).toLocal(),
          )
          .toList(),
      values: json['values']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidenceIntervalLow: json['confidenceIntervalLow']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh']
          .map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e))
          .toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }
}
