import 'package:json_annotation/json_annotation.dart';

part 'journal_event_entity.g.dart';

@JsonSerializable()
class JournalEventEntity {
  final String id;
  final String publicName;
  final String iconName;
  // @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  // final DateTime? created;
  // @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  // final DateTime? modified;

  JournalEventEntity({
    required this.id,
    required this.publicName,
    required this.iconName,
    // required this.created,
    // required this.modified,
  });

  factory JournalEventEntity.fromJson(Map<String, dynamic> json) =>
      _$JournalEventEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEventEntityToJson(this);

  // static String _dateTimeToJson(DateTime dateTime) => dateTime.toString();
  //
  // static DateTime? _dateTimeFromJson(String? date) => DateTime.parse(date ?? '01.01.1970');
}
