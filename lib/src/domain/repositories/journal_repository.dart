import '../domain.dart';

abstract class JournalRepository {
  Stream<QAResponse<String>> createJournalEntry({
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
    required List<int> ratings,
    required String oldId,
  });

  Stream<QAResponse<String>> deleteJournalEntry({
    required String id,
  });

  Stream<List<JournalEntryWithEvents>> getJournal();

  Stream<List<JournalEntryWithEvents>> getJournalSample({
    required String apiKey,
  });

  Future<JournalEntryWithEvents?> getJournalEntry(String journalEntryId);

  Stream<List<JournalEvent>> getJournalEvents();

  Stream<QAResponse<String>> sendNote(String text);
}
