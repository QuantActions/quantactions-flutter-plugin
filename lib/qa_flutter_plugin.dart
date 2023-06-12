
import 'dart:convert';

import 'qa_flutter_plugin_platform_interface.dart';
import 'package:time_machine/time_machine.dart';

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

  Stream<StatisticCore> getStat(Metric metric) {
    return QAFlutterPluginPlatform.instance.getSomeStream(metric.name).map((event) => StatisticCore.fromJson(jsonDecode(event)));
  }


}



class StatisticCore {
  final List<DateTime> timestamps;
  final List<double> data;
  StatisticCore({
    required this.timestamps,
    required this.data,
  });

  factory StatisticCore.fromJson(Map<String, dynamic> json) {
    return StatisticCore(
      timestamps: json['timestamps'].cast<String>().map<DateTime>((e) => DateTime.parse((e as String).split('[').first).toLocal()).toList(),
      data: json['data'].cast<double>(),
    );
  }
}
