import 'dart:convert';

import 'resolved_journal_event.dart';

class JournalEntryWithEvents {
  final String id;
  final DateTime timestamp;
  final String note;
  final List<ResolvedJournalEvent> events;
  final List<int> ratings;
  final Map<String, int> scores;

  JournalEntryWithEvents({
    required this.id,
    required this.timestamp,
    required this.note,
    required this.events,
    required this.ratings,
    required this.scores,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "timestamp": timestamp.millisecondsSinceEpoch,
      "note": note,
      "events": jsonEncode(
        events.map((event) => event.toJson()).toList(),
      ),
      "ratings": jsonEncode(ratings),
      "scores": jsonEncode(scores),
    };
  }
}
