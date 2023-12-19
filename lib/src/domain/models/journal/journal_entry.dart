import 'package:intl/intl.dart';
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
  final Map<String, int> scores;

  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.note,
    required this.events,
    required this.scores,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  static String _dateTimeToJson(DateTime dateTime) => DateFormat('yyyy-MM-dd').format(dateTime);

  static DateTime _dateTimeFromJson(String date) => DateTime.parse(date);
}
