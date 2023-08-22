import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';
import 'package:qa_flutter_plugin/src/data/providers/sdk_method_channel_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SDKMethodChannelImpl platform = SDKMethodChannelImpl();
  const MethodChannel channel = MethodChannel(
    MethodChannelConsts.mainMethodChannel,
  );

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        // TODO: implement
        throw UnimplementedError();
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
