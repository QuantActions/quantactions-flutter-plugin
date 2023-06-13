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
  final eventChannelSleepScore = const EventChannel('qa_flutter_plugin_stream/sleep');
  final eventChannelCognitiveFitness = const EventChannel('qa_flutter_plugin_stream/cognitive');
  final eventChannelSocialEngagementScore = const EventChannel('qa_flutter_plugin_stream/social');

  @override
  Stream<dynamic> getSomeStream(String metric) {
    debugPrint("Requesting stream for $metric");
    switch (metric) {
      case 'sleepScore':
        return eventChannelSleepScore.receiveBroadcastStream(metric);
      case 'cognitiveFitness':
        return eventChannelCognitiveFitness.receiveBroadcastStream(metric);
      case 'socialEngagementScore':
        return eventChannelSocialEngagementScore.receiveBroadcastStream(metric);
      default:
        throw UnimplementedError('getSomeStream() has not been implemented.');
    }


  }

}
