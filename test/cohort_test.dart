import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';
import 'package:quantactions_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/cohort',
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

  test('getCohortList', () {
    expect(
      qaFlutterPlugin.getCohortList(),
      const TypeMatcher<Stream<List<Cohort>>>(),
    );
  });

  test('leaveCohort', () {
    expect(
      qaFlutterPlugin.leaveCohort('', ''),
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
        case 'getCohortList':
          eventSink?.success(<Cohort>[]);
      }
    }
  }
}
