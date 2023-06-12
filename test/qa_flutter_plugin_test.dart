import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin_platform_interface.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestPluginPlatform
    with MockPlatformInterfaceMixin
    implements QAFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Stream<dynamic> getSomeStream(Map<String, String> map) {
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
  final QAFlutterPluginPlatform initialPlatform = QAFlutterPluginPlatform.instance;

  test('$MethodChannelQAFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQAFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    QA testPlugin = QA();
    MockTestPluginPlatform fakePlatform = MockTestPluginPlatform();
    QAFlutterPluginPlatform.instance = fakePlatform;

    expect(await testPlugin.getPlatformVersion(), '42');
  });
}
