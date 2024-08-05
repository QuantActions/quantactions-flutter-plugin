import 'dart:async';
import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/journal_entry/journal_entry_with_events_mapper.dart';
import '../../mappers/journal_entry/journal_event_entity_mapper.dart';
import '../../mappers/journal_entry/journal_stream_mapper.dart';
import '../providers/journal_provider.dart';

/// Journal Repository Implementation.
class JournalRepositoryImpl implements JournalRepository {
  final JournalProvider _journalProvider;

  /// Journal Repository Implementation constructor.
  JournalRepositoryImpl({
    required JournalProvider journalProvider,
  }) : _journalProvider = journalProvider;

  @override
  Future<JournalEntry> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  }) async {
    final String json = await _journalProvider.saveJournalEntry(
      id: id,
      date: date,
      note: note,
      events: events,
    );

    return JournalEntry.fromJson(jsonDecode(json));
  }

  @override
  Future<void> deleteJournalEntry({
    required String id,
  }) async {
    await _journalProvider.deleteJournalEntry(id: id);
  }

  @override
  Stream<List<JournalEntry>> getJournalEntries() {
    final Stream<dynamic> stream = _journalProvider.getJournalEntries();

    return JournalStreamMapper.getListJournalEntry(stream);
  }

  @override
  Future<JournalEntry?> getJournalEntry(String journalEntryId) async {
    final String? json = await _journalProvider.getJournalEntry(journalEntryId);

    if (json == null) return null;

    return JournalEntry.fromJson(jsonDecode(json));
  }

  @override
  Future<List<JournalEventEntity>> getJournalEventKinds() async {
    final String list = await _journalProvider.getJournalEventKinds();

    return JournalEventEntityMapper.fromList(jsonDecode(list));
  }

  @override
  Future<List<JournalEntry>> getJournalEntriesSample({
    required String apiKey,
  }) async {
    final String json =
        await _journalProvider.getJournalEntriesSample(apiKey: apiKey);

    return JournalEntryMapper.fromList(jsonDecode(json));
  }

  @override
  Future<void> sendNote(String text) async {
    await _journalProvider.sendNote(text);
  }
}
