import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../core/sdk_method_channel.dart';
import 'journal_provider.dart';

class JournalProviderImpl implements JournalProvider {
  final EventChannel _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/journal',
  );

  final SDKMethodChannel _sdkMethodChannel;

  JournalProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> createJournalEntry({
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
    required List<int> ratings,
    required String oldId,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'createJournalEntry',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'date': date.toUtc().toString(),
        'note': note,
        'events': jsonEncode(
          events.map((JournalEvent event) => event.toJson()).toList(),
        ),
        'ratings': jsonEncode(ratings),
        'oldId': oldId,
      },
    );
  }

  @override
  Stream<dynamic> deleteJournalEntry({
    required String id,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'deleteJournalEntry',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'id': id,
      },
    );
  }

  @override
  Stream<dynamic> getJournal() {
    return _sdkMethodChannel.callEventChannel(
      method: 'getJournal',
      eventChannel: _eventChannel,
    );
  }

  @override
  Future<String?> getJournalEntry(String journalEntryId) {
    return _sdkMethodChannel.callMethodChannel(
      method: 'getJournalEntry',
      params: <String, dynamic>{
        'journalEntryId': journalEntryId,
      },
    );
  }

  @override
  Stream<dynamic> getJournalEvents() {
    return _sdkMethodChannel.callEventChannel(
      method: 'getJournalEvents',
      eventChannel: _eventChannel,
    );
  }

  @override
  Stream<dynamic> getJournalSample({
    required String apiKey,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'getJournalSample',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  @override
  Stream<dynamic> sendNote(String text) {
    return _sdkMethodChannel.callEventChannel(
      method: 'sendNote',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'text': text,
      },
    );
  }
}
