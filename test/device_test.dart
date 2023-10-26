import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/device',
  );
  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockStreamHandler(eventChannel, CohortHandler());
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'isDeviceRegistered':
          return Future<bool>(() => false);
        case 'getSubscriptionIdAsync':
          return Future<String>(
            () => jsonEncode(
              QAResponse<SubscriptionIdResponse>(data: null, message: ''),
            ),
          );
        case 'syncData' || 'getDeviceID':
          return Future<String>(() => '');
      }

      return null;
    });
  });

  tearDown(() {
    binaryMessenger.setMockStreamHandler(eventChannel, null);
    binaryMessenger.setMockMethodCallHandler(methodChannel, null);
  });

  test('isDeviceRegistered', () async {
    expect(
      await qaFlutterPlugin.isDeviceRegistered(),
      const TypeMatcher<bool>(),
    );
  });

  test('subscribe', () {
    expect(
      qaFlutterPlugin.subscribe(subscriptionIdOrCohortId: ''),
      const TypeMatcher<Stream<QAResponse<SubscriptionWithQuestionnaires>>>(),
    );
  });

  test('getSubscriptionId', () {
    expect(
      qaFlutterPlugin.getSubscriptionId(),
      const TypeMatcher<Stream<QAResponse<SubscriptionIdResponse>>>(),
    );
  });

  test('getSubscriptionIdAsync', () async {
    expect(
      await qaFlutterPlugin.getSubscriptionIdAsync(),
      const TypeMatcher<QAResponse<SubscriptionIdResponse>>(),
    );
  });

  test('syncData', () async {
    expect(
      await qaFlutterPlugin.syncData(),
      const TypeMatcher<String>(),
    );
  });

  test('getDeviceID', () async {
    expect(
      await qaFlutterPlugin.deviceId,
      const TypeMatcher<String>(),
    );
  });
}

class CohortHandler implements MockStreamHandler {
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
        case 'subscribe':
          eventSink?.success(
            QAResponse<SubscriptionWithQuestionnaires>(data: null, message: null),
          );
        case 'getSubscriptionId':
          eventSink?.success(
            QAResponse<SubscriptionIdResponse>(data: null, message: null),
          );
      }
    }
  }
}
