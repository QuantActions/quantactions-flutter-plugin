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
              JournalEntry(
                id: '',
                timestamp: DateTime.now(),
                note: '',
                events: <JournalEvent>[],
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

  test('saveJournalEntry', () {
    expect(
      qaFlutterPlugin.saveJournalEntry(
        date: DateTime.now(),
        note: '',
        events: <JournalEvent>[],
      ),
      isA<void>(),
    );
  });

  test('deleteJournalEntry', () {
    expect(
      qaFlutterPlugin.deleteJournalEntry(id: ''),
      isA<void>(),
    );
  });

  test('getJournal', () {
    expect(
      qaFlutterPlugin.journalEntries(),
      const TypeMatcher<Stream<List<JournalEntry>>>(),
    );
  });

  test('getJournalEntry', () async {
    expect(
      await qaFlutterPlugin.getJournalEntry(''),
      const TypeMatcher<JournalEntry?>(),
    );
  });

  test('getJournalEvents', () {
    qaFlutterPlugin.journalEventKinds().listen((List<JournalEvent> event) {
      expect(
        event,
        const TypeMatcher<List<JournalEvent>>(),
      );
    });
  });

  test('getJournalSample', () {
    qaFlutterPlugin.getJournalSample(apiKey: '').listen((List<JournalEntry> event) {
      expect(
        event,
        const TypeMatcher<List<JournalEntry>>(),
      );
    });
  });

  test('sendNote', () async {
    expect(
      qaFlutterPlugin.sendNote,
      isA<void>(),
    );
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
        case 'getJournal' || 'getJournalSample':
          eventSink?.success(<JournalEntry>[]);
        case 'getJournalEvents':
          eventSink?.success(<JournalEvent>[]);
      }
    }
  }
}
