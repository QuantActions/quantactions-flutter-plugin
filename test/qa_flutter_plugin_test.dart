import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qa_flutter_plugin/src/data/providers/sdk_method_channel.dart';
import 'package:qa_flutter_plugin/src/data/providers/sdk_method_channel_impl.dart';

class MockTestPluginPlatform
    with MockPlatformInterfaceMixin
    implements SDKMethodChannel {
  @override
  Stream getMetricStream(Metric metric) {
    // TODO: implement getMetricStream
    throw UnimplementedError();
  }

  @override
  Stream getTrendStream(Trend trend) {
    // TODO: implement getTrendStream
    throw UnimplementedError();
  }
}

void main() {
  final SDKMethodChannel initialPlatform = SDKMethodChannel.instance;

  test('$SDKMethodChannelImpl is the default instance', () {
    expect(initialPlatform, isInstanceOf<SDKMethodChannelImpl>());
  });
}
