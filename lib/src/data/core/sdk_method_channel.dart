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
  final _methodChannel =
      const MethodChannel(MethodChannelConsts.mainMethodChannel);

  Future<T> callMethodChannel<T>({
    required String method,
    Map<String, dynamic>? params,
    //param for mock data
    MetricType? metricType,
  }) async {
    final response = await _safeRequest(
      method: method,
      request: () => _methodChannel.invokeMethod<T>(method, params),
      metricType: metricType,
    );

    if (response == null) {
      throw Exception("call $method from methodChannel return null");
    }

    return response;
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
    required String method,
    //param for mock data
    MetricType? metricType,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return request();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return MockDataProvider.callMockMethod(
        method: method,
        metricType: metricType,
      );
    } else {
      throw Exception(
        'QAFlutterPlugin is not implemented for ${Platform.operatingSystem}',
      );
    }
  }
}
