
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';

import 'qa_flutter_plugin_platform_interface.dart';


class MetricOrTrend<T> {
  const MetricOrTrend({
    required this.id,
  });

  final String id;
}

enum Metric<T> implements MetricOrTrend<T> {

  sleepScore<double>(id: 'sleep'),
  cognitiveFitness<double>(id: 'cognitive'),
  socialEngagement<double>(id: 'social'),
  actionSpeed<double>(id: 'action'),
  typingSpeed<double>(id: 'typing'),
  sleepSummary<SleepSummary>(id: 'sleep_summary'),
  screenTimeAggregate<ScreenTimeAggregate>(id: 'screen_time_aggregate'),
  socialTaps<double>(id: 'social_taps');

  const Metric({
    required this.id,
  });

  @override
  final String id;

}

enum Trend<T> implements MetricOrTrend<T> {

  sleepScore<TrendHolder>(id: 'sleep_trend'),
  cognitiveFitness<TrendHolder>(id: 'cognitive_trend'),
  socialEngagement<TrendHolder>(id: 'social_engagement_trend'),
  actionSpeed<TrendHolder>(id: 'action_trend'),
  typingSpeed<TrendHolder>(id: 'typing_trend'),
  sleepLength<TrendHolder>(id: 'sleep_length_trend'),
  sleepInterruptions<TrendHolder>(id: 'sleep_interruptions_trend'),
  socialScreenTime<TrendHolder>(id: 'social_screen_time_trend'),
  socialTaps<TrendHolder>(id: 'social_taps_trend'),
  theWave<TrendHolder>(id: 'the_wave_trend');

  const Trend({
    required this.id,
  });

  @override
  final String id;

}

// enum Trend {
//   sleepScore,
//   cognitiveFitness,
//   socialEngagement,
//   actionSpeed,
//   typingSpeed,
//   sleepLength,
//   sleepInterruptions,
//   socialScreenTime,
//   socialTaps,
// }

class QA {
  Future<String?> getPlatformVersion() {
    return QAFlutterPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> someOtherMethod(Map<String, String> map) {
    return QAFlutterPluginPlatform.instance.someOtherMethod(map);
  }

  Stream<TimeSeries<dynamic>> getMetric(MetricOrTrend metricOrTrend) {
    switch (metricOrTrend) {
      case Trend.sleepScore:
      case Trend.cognitiveFitness:
      case Trend.socialEngagement:
      case Trend.actionSpeed:
      case Trend.typingSpeed:
      case Trend.sleepLength:
      case Trend.sleepInterruptions:
      case Trend.socialScreenTime:
      case Trend.socialTaps:
      case Trend.theWave:
        var ret = QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) => TimeSeries.fromJsonTrendTimeSeries(jsonDecode(event)));
        return ret;
      // case Metric.sleepScore:
      // case Metric.cognitiveFitness:
      // case Metric.socialEngagement:
      // case Metric.actionSpeed:
      // case Metric.typingSpeed:
      case Metric.sleepSummary:
        return QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) =>
            TimeSeries.fromJsonSleepSummaryTimeSeries(jsonDecode(event))
        );
      case Metric.screenTimeAggregate:
        return QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) =>
            TimeSeries.fromJsonScreenTimeAggregateTimeSeries(jsonDecode(event))
        );
      // case Metric.socialTaps:
      default:
        return QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) =>
          TimeSeries.fromJson(jsonDecode(event))
        );

    }
    // this time series decode depends of the type of the metric
    // return QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) => TimeSeries.fromJson(jsonDecode(event)));
  }
}

class TimeSeries<T> {
  final List<T> values;
  final List<DateTime> timestamps;
  final List<T> confidenceIntervalLow;
  final List<T> confidenceIntervalHigh;
  final List<double> confidence;

  TimeSeries({
    required this.values,
    required this.timestamps,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.confidence,
  });

  TimeSeries<T> takeLast(int n) {
    return TimeSeries<T>(
      values: values.sublist(values.length - n),
      timestamps: timestamps.sublist(timestamps.length - n),
      confidenceIntervalLow: confidenceIntervalLow.sublist(confidenceIntervalLow.length - n),
      confidenceIntervalHigh: confidenceIntervalHigh.sublist(confidenceIntervalHigh.length - n),
      confidence: confidence.sublist(confidence.length - n),
    );
  }

  static TimeSeries empty() {
    return TimeSeries<SleepSummary>(
      values: List.empty(),
      timestamps:  List.empty(),
      confidenceIntervalLow: List.empty(),
      confidenceIntervalHigh: List.empty(),
      confidence: List.empty(),
    );
  }

    static TimeSeries<double> fromJson(Map<String, dynamic> json) {

    debugPrint(json.keys.toString());

    return TimeSeries<double>(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].cast<double>().map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidenceIntervalLow: json['confidenceIntervalLow'].map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<TrendHolder> fromJsonTrendTimeSeries(Map<String, dynamic> json) {
    return TimeSeries<TrendHolder>(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].map<TrendHolder>((e) => TrendHolder.fromJson(e)).toList(),
      confidenceIntervalLow: json['confidenceIntervalLow'].map<TrendHolder>((e) => TrendHolder.fromJson(e)).toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].map<TrendHolder>((e) => TrendHolder.fromJson(e)).toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<SleepSummary> fromJsonSleepSummaryTimeSeries(Map<String, dynamic> json) {
    return TimeSeries<SleepSummary>(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].map<SleepSummary>((e) => SleepSummary.fromJson(e)).toList(),
      confidenceIntervalLow: json['confidenceIntervalLow'].map<SleepSummary>((e) => SleepSummary.fromJson(e)).toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].map<SleepSummary>((e) => SleepSummary.fromJson(e)).toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(Map<String, dynamic> json) {

    return TimeSeries<ScreenTimeAggregate>(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e)).toList(),
      confidenceIntervalLow: json['confidenceIntervalLow'].map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e)).toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].map<ScreenTimeAggregate>((e) => ScreenTimeAggregate.fromJson(e)).toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

}

class TrendHolder {
  final double difference2Weeks;
  final double statistic2Weeks;
  final double significance2Weeks;
  final double difference6Weeks;
  final double statistic6Weeks;
  final double significance6Weeks;
  final double difference1Year;
  final double statistic1Year;
  final double significance1Year;

  TrendHolder({
    required this.difference2Weeks,
    required this.statistic2Weeks,
    required this.significance2Weeks,
    required this.difference6Weeks,
    required this.statistic6Weeks,
    required this.significance6Weeks,
    required this.difference1Year,
    required this.statistic1Year,
    required this.significance1Year,
  });

  factory TrendHolder.fromJson(Map<String, dynamic> json) {
    return TrendHolder(
      difference2Weeks: json['difference2Weeks'] ?? double.nan,
      statistic2Weeks: json['statistic2Weeks'] ?? double.nan,
      significance2Weeks: json['significance2Weeks'] ?? double.nan,
      difference6Weeks: json['difference6Weeks'] ?? double.nan,
      statistic6Weeks: json['statistic6Weeks'] ?? double.nan,
      significance6Weeks: json['significance6Weeks'] ?? double.nan,
      difference1Year: json['difference1Year'] ?? double.nan,
      statistic1Year: json['statistic1Year'] ?? double.nan,
      significance1Year: json['significance1Year'] ?? double.nan,
    );
  }
}

class SleepSummary{

  final DateTime sleepStart;
  final DateTime sleepEnd;
  final List<DateTime> interruptionsStart;
  final List<DateTime> interruptionsEnd;
  final List<int> interruptionsNumberOfTaps;


  SleepSummary({
    required this.sleepStart,
    required this.sleepEnd,
    required this.interruptionsStart,
    required this.interruptionsEnd,
    required this.interruptionsNumberOfTaps,
  });

  factory SleepSummary.emptySummary() {
    return SleepSummary(
        sleepStart: DateTime.fromMicrosecondsSinceEpoch(0),
        sleepEnd: DateTime.fromMicrosecondsSinceEpoch(0),
        interruptionsStart: List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
        interruptionsEnd: List.generate(1, (index) => DateTime.fromMicrosecondsSinceEpoch(0)),
        interruptionsNumberOfTaps: List.generate(1, (index) => 0));
  }

  factory SleepSummary.fromJson(Map<String, dynamic> json) {

    return SleepSummary(
      sleepStart: json['sleepStart'] == null ? DateTime.fromMicrosecondsSinceEpoch(0) : DateTime.parse((json['sleepStart'] as String).split('[').first).toLocal() ,
      sleepEnd: json['sleepEnd'] == null ? DateTime.fromMicrosecondsSinceEpoch(0) : DateTime.parse((json['sleepEnd'] as String).split('[').first).toLocal(),
      interruptionsStart: json['interruptionsStart'] == null ? List.empty() : json['interruptionsStart'].cast<String>().map((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList().cast<DateTime>(),
      interruptionsEnd: json['interruptionsEnd'] == null ? List.empty() : json['interruptionsStart'].cast<String>().map((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList().cast<DateTime>(),
      interruptionsNumberOfTaps: json['interruptionsNumberOfTaps'] == null ? List.empty() : json['interruptionsNumberOfTaps'].cast<int>(),
    );
  }
}

class ScreenTimeAggregate {
  final double totalScreenTime;
  final double socialScreenTime;

  ScreenTimeAggregate({
    required this.totalScreenTime,
    required this.socialScreenTime
  });

  factory ScreenTimeAggregate.fromJson(Map<String, dynamic> json) {

    return ScreenTimeAggregate(
      totalScreenTime: json['totalScreenTime'] ?? double.nan,
      socialScreenTime: json['socialScreenTime'] ?? double.nan,
    );
  }
}


