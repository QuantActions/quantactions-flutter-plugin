import 'package:json_annotation/json_annotation.dart';

part 'journal_event.g.dart';

@JsonSerializable()
class JournalEvent {
  final String id;
  final String eventKindID;
  final String eventName;
  final String eventIcon;
  final int? rating;

  JournalEvent({
    required this.id,
    required this.eventKindID,
    required this.eventName,
    required this.eventIcon,
    required this.rating,
  });

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

  factory JournalEvent.fromJson(Map<String, dynamic> json) =>
      _$JournalEventFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEventToJson(this);
}
