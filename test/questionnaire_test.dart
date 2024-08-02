import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';
import 'package:quantactions_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/questionnaire',
  );

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

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
      qaFlutterPlugin.recordQuestionnaireResponse(),
      isA<void>(),
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
        case 'getQuestionnairesList':
          eventSink?.success(<Questionnaire>[]);
      }
    }
  }
}
