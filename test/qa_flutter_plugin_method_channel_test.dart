import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';
import 'package:qa_flutter_plugin/src/data/core/sdk_method_channel.dart';
import 'package:qa_flutter_plugin/src/data/core/sdk_method_channel_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final SDKMethodChannelCore platform = SDKMethodChannel();
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
