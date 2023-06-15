
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';

import 'qa_flutter_plugin_platform_interface.dart';


class MetricOrTrend {
  const MetricOrTrend({
    required this.id,
  });

  final String id;
}

enum Metric implements MetricOrTrend {

  sleepScore(id: 'sleep'),
  cognitiveFitness(id: 'cognitive'),
  socialEngagement(id: 'social'),
  actionSpeed(id: 'action'),
  typingSpeed(id: 'typing'),
  sleepSummary(id: 'sleep_summary'),
  screenTimeAggregate(id: 'screen_time_aggregate'),
  socialTaps(id: 'social_taps');

  const Metric({
    required this.id,
  });

  @override
  final String id;

}

enum Trend implements MetricOrTrend {

  sleepScore(id: 'sleep_trend'),
  cognitiveFitness(id: 'cognitive_trend'),
  socialEngagement(id: 'social_engagement_trend'),
  actionSpeed(id: 'action_trend'),
  typingSpeed(id: 'typing_trend'),
  sleepLength(id: 'sleep_length_trend'),
  sleepInterruptions(id: 'sleep_interruptions_trend'),
  socialScreenTime(id: 'social_screen_time_trend'),
  socialTaps(id: 'social_taps_trend'),
  theWave(id: 'the_wave_trend');

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

  Stream<TimeSeries> getMetric(MetricOrTrend metricOrTrend) {
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
        return QAFlutterPluginPlatform.instance.getSomeStream(metricOrTrend).map((event) => TimeSeries.fromJsonTrendTimeSeries(jsonDecode(event)));
      // case Metric.sleepScore:
      // case Metric.cognitiveFitness:
      // case Metric.socialEngagement:
      // case Metric.actionSpeed:
      // case Metric.typingSpeed:
      // case Metric.sleepSummary:
      // case Metric.screenTimeAggregate:
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

  factory TimeSeries.fromJson(Map<String, dynamic> json) {
    return TimeSeries<T>(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].cast<T>().map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidenceIntervalLow: json['confidenceIntervalLow'].cast<T>().map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].cast<T>().map<double>((e) => e == null ? double.nan : e as double).toList(),
      confidence: json['confidence'].cast<double>(),
    );
  }

  factory TimeSeries.fromJsonTrendTimeSeries(Map<String, dynamic> json) {

    return TimeSeries(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      values: json['values'].cast<TrendHolder>(),
      confidenceIntervalLow: json['confidenceIntervalLow'].cast<TrendHolder>(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].cast<TrendHolder>(),
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
}

