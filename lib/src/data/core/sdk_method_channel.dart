import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../domain/domain.dart';
import '../consts/method_channel_consts.dart';
import '../mock/mock_data_provider.dart';
import 'sdk_method_channel_core.dart';

/// An implementation of [SDKMethodChannelCore] that uses method channels.
class SDKMethodChannel extends SDKMethodChannelCore {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel = const MethodChannel(MethodChannelConsts.mainMethodChannel);

  Future<T> callMethodChannel<T>({
    required String method,
    Map<String, dynamic>? params,
    // //param for mock data
    MetricType? metricType,
    MethodChannel? methodChannel,
  }) async {
    return await _safeRequest(
      request: () => methodChannel != null
          ? methodChannel.invokeMethod<T>(method, params)
          : _methodChannel.invokeMethod<T>(method, params),
      method: method,
      metricType: metricType,
    );
  }

  Stream<dynamic> callEventChannel({
    required String method,
    required EventChannel eventChannel,
    Map<String, dynamic>? params,
    //param for mock data
    MetricType? metricType,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{
      'method': method,
    };

    if (params != null) {
      data.addAll(params);
    }

    return _safeRequest(
      method: method,
      request: () => eventChannel.receiveBroadcastStream(data),
      metricType: metricType,
    );
  }

  dynamic _safeRequest({
    required Function() request,
    //params for mock data
    required String method,
    MetricType? metricType,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        return request();
      } on PlatformException catch (e) {
        throw QAError(
          description: e.message.toString(),
          reason: e.details.toString(),
        );
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return MockDataProvider.callMockMethod(
        method: method,
        metricType: metricType,
      );
    } else {
      throw QAError(
        description: 'QAFlutterPlugin is not implemented for ${Platform.operatingSystem}',
      );
    }
  }
}
