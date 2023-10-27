import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'journal_provider.dart';

class JournalProviderImpl implements JournalProvider {
  final EventChannel _getJournalEventsEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_journal_events',
  );
  final EventChannel _getJournalEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_journal',
  );
  final MethodChannel _methodChannel = const MethodChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/journal',
  );

  final SDKMethodChannel _sdkMethodChannel;

  JournalProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<dynamic> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  }) {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.saveJournalEntry,
      methodChannel: _methodChannel,
      params: <String, dynamic>{
        'id': id,
        'date': date.toUtc().toString(),
        'note': note,
        'events': jsonEncode(
          events.map((JournalEvent event) => event.toJson()).toList(),
        ),
      },
    );
  }

  @override
  Future<void> deleteJournalEntry({
    required String id,
  }) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.deleteJournalEntry,
      params: <String, dynamic>{
        'id': id,
      },
    );
  }

  @override
  Stream<dynamic> getJournal() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getJournal,
      eventChannel: _getJournalEventChannel,
    );
  }

  @override
  Future<String?> getJournalEntry(String journalEntryId) {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.getJournalEntry,
      methodChannel: _methodChannel,
      params: <String, dynamic>{
        'journalEntryId': journalEntryId,
      },
    );
  }

  @override
  Stream<dynamic> journalEventKinds() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.journalEventKinds,
      eventChannel: _getJournalEventsEventChannel,
    );
  }

  @override
  Stream<dynamic> getJournalSample({
    required String apiKey,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getJournalSample,
      eventChannel: _getJournalEventChannel,
      params: <String, dynamic>{
        'apiKey': apiKey,
      },
    );
  }

  @override
  Future<void> sendNote(String text) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.sendNote,
      params: <String, dynamic>{
        'text': text,
      },
    );
  }
}
