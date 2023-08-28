import '../../../domain/domain.dart';

abstract class JournalProvider {
  Stream<dynamic> createJournalEntry({
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
    required List<int> ratings,
    required String oldId,
  });

  Stream<dynamic> deleteJournalEntry({
    required String id,
  });

  Stream<dynamic> getJournal();

  Stream<dynamic> getJournalSample({
    required String apiKey,
  });

  Future<String?> getJournalEntry(String journalEntryId);

  Stream<dynamic> getJournalEvents();

  Stream<dynamic> sendNote(String text);
}
