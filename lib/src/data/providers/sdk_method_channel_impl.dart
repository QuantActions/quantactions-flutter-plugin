import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

import '../consts/method_channel_consts.dart';
import 'sdk_method_channel.dart';

/// An implementation of [SDKMethodChannel] that uses method channels.
class SDKMethodChannelImpl extends SDKMethodChannel {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(MethodChannelConsts.mainMethodChannel);

  @visibleForTesting
  final metricEventChannels = HashMap<Metric, EventChannel>.fromIterables(
    List<Metric>.generate(
      Metric.values.length,
      (index) => Metric.values[index],
    ),
    List<Metric>.generate(Metric.values.length, (index) => Metric.values[index])
        .map(
          (metric) => EventChannel(
            '${MethodChannelConsts.eventMethodChannelPrefix}/${metric.id}',
          ),
        )
        .toList(),
  );

  @visibleForTesting
  final trendEventChannels = HashMap<Trend, EventChannel>.fromIterables(
    List<Trend>.generate(
      Trend.values.length,
      (index) => Trend.values[index],
    ),
    List<Trend>.generate(Trend.values.length, (index) => Trend.values[index])
        .map(
          (trend) => EventChannel(
            '${MethodChannelConsts.eventMethodChannelPrefix}/${trend.id}',
          ),
        )
        .toList(),
  );

  @override
  Stream<dynamic> getMetricStream(Metric metric) {
    return metricEventChannels[metric]!.receiveBroadcastStream(metric.id);
  }

  @override
  Stream<dynamic> getTrendStream(Trend trend) {
    return trendEventChannels[trend]!.receiveBroadcastStream(trend.id);
  }
}
