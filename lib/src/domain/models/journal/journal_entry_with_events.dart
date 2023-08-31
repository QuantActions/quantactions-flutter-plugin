import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'journal_entry_with_events.g.dart';

@JsonSerializable()
class JournalEntryWithEvents {
  final String id;
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
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

  factory JournalEntryWithEvents.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryWithEventsFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntryWithEventsToJson(this);

  static int _dateTimeToJson(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);
}

// Map<String, dynamic> toJson() {
//   return <String, dynamic>{
//     "id": id,
//     "timestamp": timestamp.millisecondsSinceEpoch,
//     "note": note,
//     "events": jsonEncode(
//       events.map((event) => event.toJson()).toList(),
//     ),
//     "ratings": jsonEncode(ratings),
//     "scores": jsonEncode(scores),
//   };
// }