import '../domain.dart';

abstract class JournalRepository {
  Future<JournalEntry> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  });

  Future<void> deleteJournalEntry({
    required String id,
  });

  Stream<List<JournalEntry>> journalEntries();

  Stream<List<JournalEntry>> getJournalSample({
    required String apiKey,
  });

  Future<JournalEntry?> getJournalEntry(String journalEntryId);

  Stream<List<JournalEvent>> journalEventKinds();

  Future<void> sendNote(String text);
}
