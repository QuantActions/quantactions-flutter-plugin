import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/journal_entry/journal_entry_with_events_mapper.dart';
import '../../mappers/journal_entry/journal_stream_mapper.dart';
import '../../mappers/qa_response/qa_response_stream_mapper.dart';
import '../providers/journal_provider.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalProvider _journalProvider;

  JournalRepositoryImpl({
    required JournalProvider journalProvider,
  }) : _journalProvider = journalProvider;

  @override
  Stream<QAResponse<String>> createJournalEntry({
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
    required List<int> ratings,
    required String oldId,
  }) {
    final Stream<dynamic> stream = _journalProvider.createJournalEntry(
      date: date,
      note: note,
      events: events,
      ratings: ratings,
      oldId: oldId,
    );

    return QAResponseStreamMapper.getString(stream);
  }

  @override
  Stream<QAResponse<String>> deleteJournalEntry({
    required String id,
  }) {
    final Stream<dynamic> stream = _journalProvider.deleteJournalEntry(id: id);

    return QAResponseStreamMapper.getString(stream);
  }

  @override
  Stream<List<JournalEntryWithEvents>> getJournal() {
    final Stream<dynamic> stream = _journalProvider.getJournal();

    return JournalStreamMapper.getListEntryWithEvents(stream);
  }

  @override
  Future<JournalEntryWithEvents?> getJournalEntry(String journalEntryId) async {
    final String? json = await _journalProvider.getJournalEntry(
      journalEntryId,
    );

    if (json == null) return null;

    return JournalEntryWithEventsMapper.fromJson(jsonDecode(json));
  }

  @override
  Stream<List<JournalEvent>> getJournalEvents() {
    final Stream<dynamic> stream = _journalProvider.getJournalEvents();

    return JournalStreamMapper.getListEvent(stream);
  }

  @override
  Stream<List<JournalEntryWithEvents>> getJournalSample({
    required String apiKey,
  }) {
    final Stream<dynamic> stream = _journalProvider.getJournalSample(apiKey: apiKey);

    return JournalStreamMapper.getListEntryWithEvents(stream);
  }

  @override
  Stream<QAResponse<String>> sendNote(String text) {
    final Stream<dynamic> stream = _journalProvider.sendNote(text);

    return QAResponseStreamMapper.getString(stream);
  }
}
