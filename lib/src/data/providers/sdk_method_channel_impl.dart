import 'dart:collection';
import 'dart:io';

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
  final eventChannel =
      const EventChannel(MethodChannelConsts.eventMethodChannelPrefix);

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

  @override
  Future<bool?> canDraw() {
    return _safeRequest(
      request: () => methodChannel.invokeMethod<bool>('canDraw'),
    );
  }

  @override
  Future<bool?> canUsage() {
    return _safeRequest(
      request: () => methodChannel.invokeMethod<bool>('canUsage'),
    );
  }

  @override
  Future<bool?> isDataCollectionRunning() {
    return _safeRequest(
      request: () =>
          methodChannel.invokeMethod<bool?>('isDataCollectionRunning'),
    );
  }

  @override
  void pauseDataCollection() {
    _safeRequest(
      request: () {
        methodChannel.invokeMethod<bool?>('pauseDataCollection');
      },
    );
  }

  @override
  void resumeDataCollection() {
    _safeRequest(
      request: () {
        methodChannel.invokeMethod<bool?>('resumeDataCollection');
      },
    );
  }

  @override
  Future<bool?> isInit() {
    return _safeRequest(
      request: () => methodChannel.invokeMethod<bool?>('isInit'),
    );
  }

  @override
  Future<bool?> isDeviceRegistered() {
    return _safeRequest(
      request: () => methodChannel.invokeMethod<bool>('isDeviceRegistered'),
    );
  }

  @override
  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _safeRequest(
      request: () => methodChannel.invokeMethod<bool>(
        'initAsync',
        {
          "age": age,
          "gender": gender?.id,
          "selfDeclaredHealthy": selfDeclaredHealthy,
        },
      ),
    );
  }

  @override
  Stream<dynamic> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _safeRequest(
      request: () => eventChannel.receiveBroadcastStream({
        "event": 'init',
        "age": age,
        "gender": gender?.id,
        "selfDeclaredHealthy": selfDeclaredHealthy,
      }),
    );
  }

  @override
  void savePublicKey() {
    _safeRequest(request: () {
      methodChannel.invokeMethod<bool?>('savePublicKey');
    });
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
