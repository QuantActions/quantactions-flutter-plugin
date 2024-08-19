import 'package:json_annotation/json_annotation.dart';

part 'journal_event_entity.g.dart';

/// Journal Event Entity fot DB
@JsonSerializable()
class JournalEventEntity {
  /// ID
  final String id;

  /// Public Name
  final String publicName;

  /// Icon Name
  final String iconName;

  /// Constructor
  JournalEventEntity({
    required this.id,
    required this.publicName,
    required this.iconName,
  });

  /// From JSON factory
  factory JournalEventEntity.fromJson(Map<String, dynamic> json) =>
      _$JournalEventEntityFromJson(json);

  /// To JSON method
  Map<String, dynamic> toJson() => _$JournalEventEntityToJson(this);
}
