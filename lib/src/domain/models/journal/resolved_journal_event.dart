import 'package:json_annotation/json_annotation.dart';

part 'resolved_journal_event.g.dart';

@JsonSerializable()
class ResolvedJournalEvent {
  final String id;
  final String publicName;
  final String iconName;

  ResolvedJournalEvent({
    required this.id,
    required this.publicName,
    required this.iconName,
  });

  factory ResolvedJournalEvent.fromJson(Map<String, dynamic> json) =>
      _$ResolvedJournalEventFromJson(json);

  Map<String, dynamic> toJson() => _$ResolvedJournalEventToJson(this);
}
