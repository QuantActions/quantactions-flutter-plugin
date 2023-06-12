import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qa_flutter_plugin_platform_interface.dart';

/// An implementation of [QAFlutterPluginPlatform] that uses method channels.
class MethodChannelQAFlutterPlugin extends QAFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qa_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> someOtherMethod(Map<String, String> map) async {
    final version = await methodChannel.invokeMethod<String>('someOtherMethod', map);
    return version;
  }

  @visibleForTesting
  final eventChannel = const EventChannel('qa_flutter_plugin_stream');

  @override
  Stream<dynamic> getSomeStream(String metric) {
    return eventChannel.receiveBroadcastStream(metric);

  }

}
