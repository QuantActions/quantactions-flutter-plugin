import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../domain/domain.dart';
import '../consts/method_channel_consts.dart';
import 'sdk_method_channel_core.dart';

/// An implementation of [SDKMethodChannelCore] that uses method channels.
class SDKMethodChannel extends SDKMethodChannelCore {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel = const MethodChannel(MethodChannelConsts.mainMethodChannel);

  Future<T> callMethodChannel<T>({
    required String method,
    Map<String, dynamic>? params,
    MethodChannel? methodChannel,
  }) async {
    final T response;

    if (methodChannel != null) {
      response = await _safeRequest(
        request: () => methodChannel.invokeMethod<T>(method, params),
      );
    } else {
      response = await _safeRequest(
        request: () => _methodChannel.invokeMethod<T>(method, params),
      );
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
      request: () => eventChannel.receiveBroadcastStream(data),
    );
  }

  dynamic _safeRequest({
    required Function() request,
  }) async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        return await request();
      } on PlatformException catch (e) {
        throw QAError(
          description: e.message.toString(),
          reason: e.details.toString(),
        );
      }
    } else {
      throw QAError(
        description: 'QAFlutterPlugin is not implemented for ${Platform.operatingSystem}',
      );
    }
  }
}
