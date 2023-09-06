import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/user',
  );
  const methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);
  final binaryMessenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockStreamHandler(eventChannel, UserHandler());
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'isInit' || 'initAsync':
          return Future(() => false);
        case 'getBasicInfo':
          return Future(
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

  test('isInit', () async {
    expect(
      await qaFlutterPlugin.isInit(),
      const TypeMatcher<bool>(),
    );
  });

  test('initAsync', () async {
    expect(
      await qaFlutterPlugin.initAsync(apiKey: ''),
      const TypeMatcher<bool>(),
    );
  });

  test('init', () {
    expect(
      qaFlutterPlugin.init(apiKey: ''),
      const TypeMatcher<Stream<QAResponse<String>>>(),
    );
  });

  test('savePublicKey', () {
    expect(
      () => qaFlutterPlugin.savePublicKey(),
      isA<void>(),
    );
  });

  test('setVerboseLevel', () {
    expect(
      () => qaFlutterPlugin.setVerboseLevel(1),
      isA<void>(),
    );
  });

  test('validateToken', () {
    expect(
      qaFlutterPlugin.validateToken(apiKey: ''),
      const TypeMatcher<Stream<QAResponse<String>>>(),
    );
  });

  test('updateBasicInfo', () {
    expect(
      () => qaFlutterPlugin.updateBasicInfo(),
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

    final params = arguments as Map<String, dynamic>;

    switch (params['method']) {
      case 'init' || 'validateToken':
        eventSink?.success(
          QAResponse<String>(data: null, message: null),
        );
    }
  }
}
