import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/journal_entry/journal_stream_mapper.dart';
import '../providers/journal_provider.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalProvider _journalProvider;

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
    final Map<String, dynamic> map = await _journalProvider.saveJournalEntry(
      id: id,
      date: date,
      note: note,
      events: events,
    );

    return JournalEntry.fromJson(map);
  }

  @override
  Future<void> deleteJournalEntry({
    required String id,
  }) async {
    await _journalProvider.deleteJournalEntry(id: id);
  }

  @override
  Stream<List<JournalEntry>> journalEntries() {
    final Stream<dynamic> stream = _journalProvider.getJournal();

    return JournalStreamMapper.getListEntryWithEvents(stream);
  }

  @override
  Future<JournalEntry?> getJournalEntry(String journalEntryId) async {
    final String? json = await _journalProvider.getJournalEntry(
      journalEntryId,
    );

    if (json == null) return null;

    return JournalEntry.fromJson(jsonDecode(json));
  }

  @override
  Stream<List<JournalEvent>> journalEventKinds() {
    final Stream<dynamic> stream = _journalProvider.journalEventKinds();

    return JournalStreamMapper.getListEvent(stream);
  }

  @override
  Stream<List<JournalEntry>> getJournalSample({
    required String apiKey,
  }) {
    final Stream<dynamic> stream = _journalProvider.getJournalSample(apiKey: apiKey);

    return JournalStreamMapper.getListEntryWithEvents(stream);
  }

  @override
  Future<void> sendNote(String text) async {
    await _journalProvider.sendNote(text);
  }
}
