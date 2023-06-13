
import 'dart:convert';
import 'dart:core';

import 'qa_flutter_plugin_platform_interface.dart';

enum Metric {
  sleepScore,
  cognitiveFitness,
  socialEngagementScore,
}

class QA {
  Future<String?> getPlatformVersion() {
    return QAFlutterPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> someOtherMethod(Map<String, String> map) {
    return QAFlutterPluginPlatform.instance.someOtherMethod(map);
  }

  Stream<TimeSeries> getStat(Metric metric) {
    return QAFlutterPluginPlatform.instance.getSomeStream(metric.name).map((event) => TimeSeries.fromJson(jsonDecode(event)));
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
      values: json['values'].cast<T>(),
      confidenceIntervalLow: json['confidenceIntervalLow'].cast<T>(),
      confidenceIntervalHigh: json['confidenceIntervalHigh'].cast<T>(),
      confidence: json['confidence'].cast<double>(),
    );
  }

}



// class StatisticCore {
//   final List<DateTime> timestamps;
//   final List<double> data;
//   StatisticCore({
//     required this.timestamps,
//     required this.data,
//   });
//
//   factory StatisticCore.fromJson(Map<String, dynamic> json) {
//     return StatisticCore(
//       timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
//       data: json['data'].cast<double>(),
//     );
//   }
// }
