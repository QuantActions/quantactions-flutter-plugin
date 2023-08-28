import '../models/journal_entry/journal_entry.dart';
import '../models/journal_entry/journal_event.dart';
import '../models/qa_response/qa_response.dart';

abstract class JournalRepository {
  Stream<QAResponse<String>> createJournalEntry({
    required JournalEntry journalEntry,
  });

  Stream<QAResponse<String>> deleteJournalEntry({
    required String id,
  });

  Stream<List<JournalEntry>> getJournal();

  Stream<List<JournalEntry>> getJournalSample({
    required String apiKey,
  });

  Future<JournalEntry?> getJournalEntry();

  Future<List<JournalEvent>> getJournalEvents();

  Stream<QAResponse<String>> sendNote(String text);
}
