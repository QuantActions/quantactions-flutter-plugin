import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../consts/method_channel_consts.dart';
import 'sdk_method_channel_core.dart';

/// An implementation of [SDKMethodChannelCore] that uses method channels.
class SDKMethodChannel extends SDKMethodChannelCore {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel = const MethodChannel(MethodChannelConsts.mainMethodChannel);

  Future<T> callMethodChannel<T>({
    required String method,
    Map<String, dynamic>? params,
  }) async {
    final T response = await _safeRequest(
      request: () => _methodChannel.invokeMethod<T>(method, params),
      method: method,
    );

    if (response == null) {
      throw Exception('call $method from methodChannel return null');
    }

    return response;
  }

  Stream<dynamic> callEventChannel({
    required String method,
    required EventChannel eventChannel,
    Map<String, dynamic>? params,
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
    );
  }

  dynamic _safeRequest({
    required Function() request,
    required String method,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      return request();
    } else {
      throw Exception(
        'QAFlutterPlugin is not implemented for ${Platform.operatingSystem}',
      );
    }
  }
}
