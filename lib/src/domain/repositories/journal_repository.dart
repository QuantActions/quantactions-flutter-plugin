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

  Stream<List<JournalEntry>> getJournalEntries();

  Future<List<JournalEntry>> getJournalEntriesSample({
    required String apiKey,
  });

  Future<JournalEntry?> getJournalEntry(String journalEntryId);

  Future<List<JournalEventEntity>> getJournalEventKinds();

  Future<void> sendNote(String text);
}
