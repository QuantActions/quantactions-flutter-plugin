import 'dart:collection';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../domain/domain.dart';
import '../consts/method_channel_consts.dart';
import 'sdk_method_channel_core.dart';

/// An implementation of [SDKMethodChannelCore] that uses method channels.
class SDKMethodChannel extends SDKMethodChannelCore {
  /// The method channel used to interact with the native platform.
  final _methodChannel =
      const MethodChannel(MethodChannelConsts.mainMethodChannel);

  final _eventChannel =
      const EventChannel(MethodChannelConsts.eventMethodChannelPrefix);

  final _metricEventChannels = HashMap<Metric, EventChannel>.fromIterables(
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

  final _trendEventChannels = HashMap<Trend, EventChannel>.fromIterables(
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

  Future<T?> callMethodChannel<T>({
    required String method,
    Map<String, dynamic>? params,
  }) {
    return _safeRequest(
      request: () => _methodChannel.invokeMethod<T>(method, params),
    );
  }

  Stream<dynamic> callEventChannel({
    required String method,
    Map<String, dynamic>? params,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{
      "event": method,
    };

    if (params != null) {
      data.addAll(params);
    }

    return _safeRequest(
      request: () => _eventChannel.receiveBroadcastStream(data),
    );
  }

  Stream<dynamic> callMetricEventChannel(Metric metric) {
    return _safeRequest(
      request: () =>
          _metricEventChannels[metric]!.receiveBroadcastStream(metric.id),
    );
  }

  Stream<dynamic> callTrendEventChannel(Trend trend) {
    return _safeRequest(
      request: () =>
          _trendEventChannels[trend]!.receiveBroadcastStream(trend.id),
    );
  }

  dynamic _safeRequest({
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
