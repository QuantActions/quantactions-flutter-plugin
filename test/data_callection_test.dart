import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';
import 'package:quantactions_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'isDataCollectionRunning':
          return Future<bool>(() => false);
      }

      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall message) => null);
  });

  test('isDataCollectionRunning', () async {
    expect(
      await qaFlutterPlugin.isDataCollectionRunning(),
      const TypeMatcher<bool>(),
    );
  });

  test('pauseDataCollection', () async {
    expect(
      qaFlutterPlugin.pauseDataCollection,
      isA<void>(),
    );
  });

  test('resumeDataCollection', () {
    expect(
      qaFlutterPlugin.resumeDataCollection,
      isA<void>(),
    );
  });
}
