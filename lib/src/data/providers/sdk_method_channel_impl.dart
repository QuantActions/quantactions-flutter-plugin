import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

import 'sdk_method_channel.dart';

/// An implementation of [SDKMethodChannel] that uses method channels.
class SDKMethodChannelImpl extends SDKMethodChannel {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qa_flutter_plugin');

  @visibleForTesting
  final metricEventChannels = HashMap<Metric, EventChannel>.fromIterables(
    List<Metric>.generate(
      Metric.values.length,
      (index) => Metric.values[index],
    ),
    List<Metric>.generate(Metric.values.length, (index) => Metric.values[index])
        .map((metric) => EventChannel('qa_flutter_plugin_stream/${metric.id}'))
        .toList(),
  );

  @visibleForTesting
  final trendEventChannels = HashMap<Trend, EventChannel>.fromIterables(
    List<Trend>.generate(
      Trend.values.length,
      (index) => Trend.values[index],
    ),
    List<Trend>.generate(Trend.values.length, (index) => Trend.values[index])
        .map((trend) => EventChannel('qa_flutter_plugin_stream/${trend.id}'))
        .toList(),
  );

  @override
  Stream<dynamic> getMetricStream(Metric metric) {
    return _safeRequest(
      request: () =>
          metricEventChannels[metric]!.receiveBroadcastStream(metric.id),
    );
  }

  @override
  Stream<dynamic> getTrendStream(Trend trend) {
    return _safeRequest(
      request: () =>
          trendEventChannels[trend]!.receiveBroadcastStream(trend.id),
    );
  }

  Stream<dynamic> _safeRequest({
    required Function() request,
  }) {
    if (!Platform.isAndroid) {
      throw Exception(
        'QAFlutterPlugin for ${Platform.operatingSystem} platform not yet implemented',
      );
    } else {
      return request();
    }
  }
}
