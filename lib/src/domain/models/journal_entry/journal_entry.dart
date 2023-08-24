import 'journal_event.dart';

class JournalEntry {
  final DateTime date;
  final String note;
  final List<JournalEvent> events;
  final List<int> ratings;
  final String oldId;

  JournalEntry({
    required this.date,
    required this.note,
    required this.events,
    required this.ratings,
    required this.oldId,
  });
}
