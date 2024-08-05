import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'journal_entry.g.dart';

/// Journal Entry
@JsonSerializable()
class JournalEntry {
  /// ID
  final String id;
  @JsonKey(
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )

  /// Timestamp of the entry
  final DateTime timestamp;

  /// Note associated with the entry
  final String note;

  /// Events associated with the entry
  final List<JournalEvent> events;

  /// Scores associated with the entry (metrics)
  final Map<String, int> scores;

  /// Constructor
  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.note,
    required this.events,
    required this.scores,
  });

  /// Copy with
  JournalEntry copyWith({
    String? id,
    DateTime? timestamp,
    String? note,
    List<JournalEvent>? events,
    Map<String, int>? scores,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
      events: events ?? this.events,
      scores: scores ?? this.scores,
    );
  }

  /// From JSON factory
  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);

  /// To JSON method
  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  static String _dateTimeToJson(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);

  static DateTime _dateTimeFromJson(String date) {
    return DateTime.parse(date);
  }
}
