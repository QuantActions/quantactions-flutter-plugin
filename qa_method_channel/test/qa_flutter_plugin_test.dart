import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qa_method_channel/qa_method_channel.dart';
import 'package:qa_method_channel/src/qa_flutter_plugin/qa_flutter_plugin_method_channel.dart';
import 'package:qa_method_channel/src/qa_flutter_plugin/qa_flutter_plugin_platform.dart';

class MockTestPluginPlatform
    with MockPlatformInterfaceMixin
    implements QAFlutterPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Stream<dynamic> getStreamBy({
    required MetricOrTrend metricOrTrend,
  }) {
    // TODO: implement getSomeStream
    throw UnimplementedError();
  }

  @override
  Future<String?> someOtherMethod(Map<String, String> map) {
    // TODO: implement someOtherMethod
    throw UnimplementedError();
  }
}

void main() {
  final QAFlutterPluginPlatform initialPlatform =
      QAFlutterPluginPlatform.instance;

  test('$QAFlutterPluginMethodChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<QAFlutterPluginMethodChannel>());
  });

  test('getPlatformVersion', () async {
    QAMethodChannel testPlugin = QAMethodChannel.instance;
    MockTestPluginPlatform fakePlatform = MockTestPluginPlatform();
    QAFlutterPluginPlatform.instance = fakePlatform;

    expect(await testPlugin.getPlatformVersion(), '42');
  });
}
