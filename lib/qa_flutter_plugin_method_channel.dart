import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

import 'qa_flutter_plugin_platform_interface.dart';

/// An implementation of [QAFlutterPluginPlatform] that uses method channels.
class MethodChannelQAFlutterPlugin extends QAFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qa_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> someOtherMethod(Map<String, String> map) async {
    final version = await methodChannel.invokeMethod<String>('someOtherMethod', map);
    return version;
  }

  @visibleForTesting
  // final eventChannels = Metric.values.map((metric) => EventChannel('qa_flutter_plugin_stream/${metric.id}')).toList();
  final eventChannels = HashMap<MetricOrTrend, EventChannel>.fromIterables(
      List<MetricOrTrend>.generate(Metric.values.length + Trend.values.length, (index) => ((index < Metric.values.length) ? Metric.values[index] : Trend.values[index - Metric.values.length] as MetricOrTrend)),
      List<MetricOrTrend>.generate(Metric.values.length + Trend.values.length, (index) => ((index < Metric.values.length) ? Metric.values[index] : Trend.values[index - Metric.values.length] as MetricOrTrend)).map((metricOrTrend) => EventChannel('qa_flutter_plugin_stream/${metricOrTrend.id}')).toList());

  // final eventChannelSleepScore = const EventChannel('qa_flutter_plugin_stream/sleep');
  // final eventChannelCognitiveFitness = const EventChannel('qa_flutter_plugin_stream/cognitive');
  // final eventChannelSocialEngagementScore = const EventChannel('qa_flutter_plugin_stream/social');

  @override
  Stream<dynamic> getSomeStream(MetricOrTrend metricOrTrend) {
    return eventChannels[metricOrTrend]!.receiveBroadcastStream(metricOrTrend.id);
  }

}
