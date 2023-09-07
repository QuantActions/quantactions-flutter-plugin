import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      return Future<bool>(() => false);
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall message) => null);
  });

  test('canDraw', () async {
    expect(
      await qaFlutterPlugin.canDraw(),
      const TypeMatcher<bool>(),
    );
  });

  test('canUsage', () async {
    expect(
      await qaFlutterPlugin.canUsage(),
      isA<void>(),
    );
  });
}
