import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'journal_entry.g.dart';

@JsonSerializable()
class JournalEntry {
  final String id;
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime timestamp;
  final String note;
  final List<JournalEvent> events;
  final List<int> ratings;
  final Map<String, int> scores;

  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.note,
    required this.events,
    required this.ratings,
    required this.scores,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  static int _dateTimeToJson(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);
}
