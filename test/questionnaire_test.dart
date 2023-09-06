import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/questionnaire',
  );
  final binaryMessenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockStreamHandler(eventChannel, CohortHandler());
  });

  tearDown(() {
    binaryMessenger.setMockStreamHandler(eventChannel, null);
  });

  test('getQuestionnairesList', () {
    expect(
      qaFlutterPlugin.getQuestionnairesList(),
      const TypeMatcher<Stream<List<Questionnaire>>>(),
    );
  });

  test('recordQuestionnaireResponse', () {
    expect(
      qaFlutterPlugin.recordQuestionnaireResponse(
        name: null,
        code: null,
        date: null,
        fullId: null,
        response: null,
      ),
      const TypeMatcher<Stream<QAResponse<String>>>(),
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

    final params = arguments as Map<String, dynamic>;

    switch (params['method']) {
      case 'getQuestionnairesList':
        eventSink?.success(<Questionnaire>[]);
      case 'recordQuestionnaireResponse':
        eventSink?.success(
          QAResponse<String>(data: null, message: null),
        );
    }
  }
}
