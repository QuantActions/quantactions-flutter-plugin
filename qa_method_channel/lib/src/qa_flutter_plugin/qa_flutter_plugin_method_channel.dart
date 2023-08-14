import 'dart:collection';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qa_flutter_plugin_platform.dart';


/// An implementation of [QAFlutterPluginPlatform] that uses method channels.
class QAFlutterPluginMethodChannel extends QAFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qa_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> someOtherMethod(Map<String, String> map) async {
    final version =
        await methodChannel.invokeMethod<String>('someOtherMethod', map);
    return version;
  }

  @visibleForTesting
  final eventChannels = HashMap<MetricOrTrend, EventChannel>.fromIterables(
    List<MetricOrTrend>.generate(
        Metric.values.length + Trend.values.length,
        (index) => ((index < Metric.values.length)
            ? Metric.values[index]
            : Trend.values[index - Metric.values.length] as MetricOrTrend)),
    List<MetricOrTrend>.generate(
            Metric.values.length + Trend.values.length,
            (index) => ((index < Metric.values.length)
                ? Metric.values[index]
                : Trend.values[index - Metric.values.length] as MetricOrTrend))
        .map((metricOrTrend) =>
            EventChannel('qa_flutter_plugin_stream/${metricOrTrend.id}'))
        .toList(),
  );

  Stream<dynamic> getSomeStream(MetricOrTrend metricOrTrend) {
    return eventChannels[metricOrTrend]!
        .receiveBroadcastStream(metricOrTrend.id);
  }
}
