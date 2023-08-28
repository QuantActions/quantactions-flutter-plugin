import 'dart:io';

import 'package:flutter/services.dart';

import '../consts/method_channel_consts.dart';
import 'sdk_method_channel_core.dart';

/// An implementation of [SDKMethodChannelCore] that uses method channels.
class SDKMethodChannel extends SDKMethodChannelCore {
  /// The method channel used to interact with the native platform.
  final _methodChannel =
      const MethodChannel(MethodChannelConsts.mainMethodChannel);

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
      request: () => eventChannel.receiveBroadcastStream(data),
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
