import 'package:json_annotation/json_annotation.dart';

part 'journal_event.g.dart';

/// Journal Event
@JsonSerializable()
class JournalEvent {
  /// ID
  final String id;

  /// Event Kind ID
  final String eventKindID;

  /// Event Name
  final String eventName;

  /// Event Icon
  final String eventIcon;

  /// Rating [1-5]
  final int? rating;

  /// Constructor
  JournalEvent({
    required this.id,
    required this.eventKindID,
    required this.eventName,
    required this.eventIcon,
    required this.rating,
  });

  /// Copy with rating
  JournalEvent copyWithRating({
    int? rating,
  }) {
    return JournalEvent(
      id: id,
      eventKindID: eventKindID,
      eventName: eventName,
      eventIcon: eventIcon,
      rating: rating,
    );
  }

  /// From JSON factory
  factory JournalEvent.fromJson(Map<String, dynamic> json) =>
      _$JournalEventFromJson(json);

  /// To JSON method
  Map<String, dynamic> toJson() => _$JournalEventToJson(this);
}
