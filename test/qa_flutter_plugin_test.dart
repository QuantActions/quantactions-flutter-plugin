import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qa_flutter_plugin/src/data/core/sdk_method_channel_core.dart';

class MockTestPluginPlatform with MockPlatformInterfaceMixin implements SDKMethodChannelCore {}

void main() {
  final SDKMethodChannelCore initialPlatform = SDKMethodChannelCore.instance;

  test('$SDKMethodChannelCore is the default instance', () {
    expect(initialPlatform, isInstanceOf<SDKMethodChannelCore>());
  });
}
