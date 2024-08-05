import '../../../domain/domain.dart';

/// Journal Provider
abstract class JournalProvider {
  /// Use this utility function to create or edit a journal entry. In case you want to edit a note
  /// you will need to pass the ID of the entity to edit. The function returns an asynchronous flow
  /// with the response of the action. The response is mostly to trigger UI/UX events, in case of
  /// failure the SDK will take care internally of retrying.
  /// [id] is the ID of the journal entry to edit. No need to set it when creating a new entry.
  /// [date] is the date of the journal entry.
  /// [note] is the note of the journal entry.
  /// [events] is the list of events of the journal entry.
  Future<dynamic> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  });

  /// Use this function to delete a journal entry. You need to provide the id of the entry you
  /// want to delete, checkout [getJournalEntries] and [JournalEntry] to see how to retrieve
  /// the id of the entry to delete.
  Future<void> deleteJournalEntry({
    required String id,
  });

  /// This functions returns the full journal of the device, meaning all entries with the
  /// corresponding events. Checkout [JournalEntry] for a complete description of how the
  /// journal entries are organized.
  /// @return A flow with a list of [JournalEntry]
  Stream<dynamic> getJournalEntries();

  /// This functions returns a fictitious journal and can be used for test/display purposes,
  /// Checkout [JournalEntry] for a complete description of how the journal entries are
  /// organized.
  Future<dynamic> getJournalEntriesSample({
    required String apiKey,
  });

  /// Use this function to retrieve a particular journal entry. You need to provide the id of the
  /// entry you want to retrieve, checkout [getJournalEntries] and [JournalEntry] to see how to
  /// retrieve the id of the entry.
  Future<String?> getJournalEntry(String journalEntryId);

  /// Retrieves the Journal events, meaning the events that one can log together with a journal
  /// entry. The events come from a fixed set which may be updated in the future, this function
  /// return the latest update to the [JournalEventEntity].
  /// @return A list of [JournalEventEntity]
  Future<dynamic> getJournalEventKinds();

  /// Saves simple text note.
  /// [text] simple text
  Future<void> sendNote(String text);
}
