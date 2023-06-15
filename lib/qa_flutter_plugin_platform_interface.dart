import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

import 'qa_flutter_plugin_method_channel.dart';

abstract class QAFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a TestPluginPlatform.
  QAFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static QAFlutterPluginPlatform _instance = MethodChannelQAFlutterPlugin();

  /// The default instance of [QAFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelQAFlutterPlugin].
  static QAFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QAFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(QAFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> someOtherMethod(Map<String, String> map) {
    throw UnimplementedError('someOtherMethod() has not been implemented.');
  }

  Stream<dynamic> getSomeStream(MetricOrTrend metricOrTrend) {
    throw UnimplementedError('someOtherMethod() has not been implemented.');
  }

}
