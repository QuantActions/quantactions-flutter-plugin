import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);
  final binaryMessenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'isDataCollectionRunning':
          return Future(() => false);
      }

      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (message) => null);
  });

  test('isDataCollectionRunning', () async {
    expect(
      await qaFlutterPlugin.isDataCollectionRunning(),
      const TypeMatcher<bool>(),
    );
  });

  test('pauseDataCollection', () async {
    expect(
      () => qaFlutterPlugin.pauseDataCollection(),
      isA<void>(),
    );
  });

  test('resumeDataCollection', () {
    expect(
      () => qaFlutterPlugin.resumeDataCollection(),
      isA<void>(),
    );
  });
}
