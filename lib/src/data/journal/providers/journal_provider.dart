import '../../../domain/domain.dart';

abstract class JournalProvider {
  Future<dynamic> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  });

  Future<void> deleteJournalEntry({
    required String id,
  });

  Stream<dynamic> getJournal();

  Stream<dynamic> getJournalSample({
    required String apiKey,
  });

  Future<String?> getJournalEntry(String journalEntryId);

  Stream<dynamic> journalEventKinds();

  Future<void> sendNote(String text);
}
