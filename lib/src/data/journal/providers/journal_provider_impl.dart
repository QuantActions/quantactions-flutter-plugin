import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../domain/domain.dart';
import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'journal_provider.dart';

class JournalProviderImpl implements JournalProvider {
  final EventChannel _getJournalEventKindsEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_journal_event_kinds',
  );
  final EventChannel _getJournalEntriesChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_journal_entries',
  );
  final MethodChannel _getJournalEntryMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/get_journal_entry',
  );
  final MethodChannel _saveJournalEntryMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/save_journal_entry',
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
      methodChannel: _saveJournalEntryMethodChannel,
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
  Stream<dynamic> getJournalEntries() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.journalEntries,
      eventChannel: _getJournalEntriesChannel,
    );
  }

  @override
  Future<String?> getJournalEntry(String journalEntryId) async {
    return _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.getJournalEntry,
      methodChannel: _getJournalEntryMethodChannel,
      params: <String, dynamic>{
        'journalEntryId': journalEntryId,
      },
    );
  }

  @override
  Stream<dynamic> getJournalEventKinds() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.journalEventKinds,
      eventChannel: _getJournalEventKindsEventChannel,
    );
  }

  @override
  Stream<dynamic> getJournalEntriesSample({
    required String apiKey,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.journalEntriesSample,
      eventChannel: _getJournalEntriesChannel,
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
