import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qa_flutter_plugin/src/data/core/sdk_method_channel_core.dart';

class MockTestPluginPlatform
    with MockPlatformInterfaceMixin
    implements SDKMethodChannelCore {
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

  @override
  Future<bool?> canDraw() {
    // TODO: implement canDraw
    throw UnimplementedError();
  }

  @override
  Future<bool?> canUsage() {
    // TODO: implement canDraw
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDataCollectionRunning() {
    // TODO: implement canDraw
    throw UnimplementedError();
  }

  @override
  Future<bool?> isInit() {
    // TODO: implement canDraw
    throw UnimplementedError();
  }

  @override
  Future<bool> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    // TODO: implement initAsync
    throw UnimplementedError();
  }

  @override
  Stream<bool> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDeviceRegistered() {
    // TODO: implement isDeviceRegistered
    throw UnimplementedError();
  }

  @override
  void pauseDataCollection() {
    // TODO: implement pauseDataCollection
  }

  @override
  void resumeDataCollection() {
    // TODO: implement resumeDataCollection
  }

  @override
  void savePublicKey() {
    // TODO: implement savePublicKey
  }
}

void main() {
  final SDKMethodChannelCore initialPlatform = SDKMethodChannelCore.instance;

  test('$SDKMethodChannelCore is the default instance', () {
    expect(initialPlatform, isInstanceOf<SDKMethodChannelCore>());
  });
}
