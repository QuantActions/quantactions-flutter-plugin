import 'package:json_annotation/json_annotation.dart';

part 'journal_event.g.dart';

@JsonSerializable()
class JournalEvent {
  final String id;
  final String publicName;
  final String iconName;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime created;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime modified;

  JournalEvent({
    required this.id,
    required this.publicName,
    required this.iconName,
    required this.created,
    required this.modified,
  });

  factory JournalEvent.fromJson(Map<String, dynamic> json) =>
      _$JournalEventFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEventToJson(this);

  static int _dateTimeToJson(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);
}
