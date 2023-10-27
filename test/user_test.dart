import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/user',
  );
  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockStreamHandler(eventChannel, UserHandler());
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'getBasicInfo':
          return Future<String>(
            () => jsonEncode(
              BasicInfo(
                yearOfBirth: 1991,
                gender: Gender.male,
                selfDeclaredHealthy: false,
              ),
            ),
          );
      }
      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockMethodCallHandler(methodChannel, null);
    binaryMessenger.setMockStreamHandler(eventChannel, null);
  });

  test('init', () {
    expect(
      qaFlutterPlugin.init(apiKey: ''),
      const TypeMatcher<bool>(),
    );
  });

  test('updateBasicInfo', () {
    expect(
      qaFlutterPlugin.updateBasicInfo,
      isA<void>(),
    );
  });

  test('getBasicInfo', () async {
    expect(
      await qaFlutterPlugin.basicInfo,
      const TypeMatcher<BasicInfo>(),
    );
  });
}

class UserHandler implements MockStreamHandler {
  MockStreamHandlerEventSink? eventSink;

  @override
  void onCancel(Object? arguments) {
    eventSink = null;
  }

  @override
  void onListen(Object? arguments, MockStreamHandlerEventSink events) {
    eventSink = events;

    if (arguments != null) {
      final Map<String, dynamic> params = arguments as Map<String, dynamic>;

      switch (params['method']) {
        case 'init':
          eventSink?.success(true);
      }
    }
  }
}
