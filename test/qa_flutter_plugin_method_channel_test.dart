import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/src/data/providers/sdk_method_channel_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SDKMethodChannelImpl platform = SDKMethodChannelImpl();
  const MethodChannel channel = MethodChannel('qa_flutter_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await platform.getPlatformVersion(), '42');
  // });
}
