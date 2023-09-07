import 'dart:collection';

import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import 'metric_provider.dart';

class MetricProviderImpl implements MetricProvider {
  final HashMap<MetricType, EventChannel> _eventChannels =
      HashMap<MetricType, EventChannel>.fromIterables(
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (int index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    ),
    List<MetricType>.generate(
      Metric.values.length + Trend.values.length,
      (int index) => ((index < Metric.values.length)
          ? Metric.values[index]
          : Trend.values[index - Metric.values.length] as MetricType),
    )
        .map((MetricType metricType) => EventChannel('qa_flutter_plugin_stream/${metricType.id}'))
        .toList(),
  );

  final SDKMethodChannel _sdkMethodChannel;

  MetricProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getMetric(MetricType metric) {
    return _sdkMethodChannel.callEventChannel(
      method: 'getMetric',
      eventChannel: _eventChannels[metric]!,
      params: <String, dynamic>{
        'metric': metric.id,
      },
    );
  }

  @override
  Future<String?> getMetricAsync(MetricType metric) {
    return _sdkMethodChannel.callMethodChannel(
      method: 'getMetricAsync',
      params: <String, dynamic>{
        'metric': metric.id,
      },
    );
  }

  @override
  Stream<dynamic> getMetricSample({
    required String apiKey,
    required MetricType metric,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'getMetricSample',
      eventChannel: _eventChannels[metric]!,
      params: <String, dynamic>{
        'apiKey': apiKey,
        'metric': metric.id,
      },
    );
  }

  @override
  Future<String?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  }) {
    return _sdkMethodChannel.callMethodChannel(
      method: 'getStatSampleAsync',
      params: <String, dynamic>{
        'apiKey': apiKey,
        'metric': metric.id,
      },
    );
  }
}
