import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/consts/method_channel_consts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const EventChannel eventChannel = EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/journal',
  );
  const MethodChannel methodChannel = MethodChannel(MethodChannelConsts.mainMethodChannel);

  final TestDefaultBinaryMessenger binaryMessenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  final QAFlutterPlugin qaFlutterPlugin = QAFlutterPlugin();

  setUp(() {
    binaryMessenger.setMockStreamHandler(eventChannel, JournalHandler());
    binaryMessenger.setMockMethodCallHandler(methodChannel, (MethodCall methodCall) {
      switch (methodCall.method) {
        case 'getJournalEntry':
          return Future<String>(
            () => jsonEncode(
              JournalEntryWithEvents(
                id: '',
                timestamp: DateTime.now(),
                note: '',
                events: <ResolvedJournalEvent>[],
                ratings: <int>[],
                scores: <String, int>{},
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

  test('createJournalEntry', () {
    expect(
      qaFlutterPlugin.createJournalEntry(
        date: DateTime.now(),
        note: '',
        events: <JournalEvent>[],
        ratings: <int>[],
        oldId: '',
      ),
      const TypeMatcher<Stream<QAResponse<String>>>(),
    );
  });

  test('deleteJournalEntry', () {
    expect(
      qaFlutterPlugin.deleteJournalEntry(id: ''),
      const TypeMatcher<Stream<QAResponse<String>>>(),
    );
  });

  test('getJournal', () {
    expect(
      qaFlutterPlugin.getJournal(),
      const TypeMatcher<Stream<List<JournalEntryWithEvents>>>(),
    );
  });

  test('getJournalEntry', () async {
    expect(
      await qaFlutterPlugin.getJournalEntry(''),
      const TypeMatcher<JournalEntryWithEvents?>(),
    );
  });

  test('getJournalEvents', () {
    qaFlutterPlugin.getJournalEvents().listen((List<JournalEvent> event) {
      expect(
        event,
        const TypeMatcher<List<JournalEvent>>(),
      );
    });
  });

  test('getJournalSample', () {
    qaFlutterPlugin.getJournalSample(apiKey: '').listen((List<JournalEntryWithEvents> event) {
      expect(
        event,
        const TypeMatcher<List<JournalEntryWithEvents>>(),
      );
    });
  });

  test('sendNote', () {
    qaFlutterPlugin.sendNote('').listen((QAResponse<String> event) {
      expect(
        event,
        const TypeMatcher<QAResponse<String>>(),
      );
    });
  });
}

class JournalHandler implements MockStreamHandler {
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
        case 'createJournalEntry':
          eventSink?.success(
            QAResponse<String>(data: null, message: null),
          );
        case 'deleteJournalEntry' || 'sendNote':
          eventSink?.success(
            QAResponse<String>(data: null, message: null),
          );
        case 'getJournal' || 'getJournalSample':
          eventSink?.success(<JournalEntryWithEvents>[]);
        case 'getJournalEvents':
          eventSink?.success(<JournalEvent>[]);
      }
    }
  }
}
