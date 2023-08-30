import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolved_journal_event.g.dart';

part 'resolved_journal_event.freezed.dart';

@freezed
class ResolvedJournalEvent with _$ResolvedJournalEvent {
  factory ResolvedJournalEvent({
    required String id,
    required String publicName,
    required String iconName,
  }) = _ResolvedJournalEvent;

  factory ResolvedJournalEvent.fromJson(Map<String, dynamic> json) =>
      _$ResolvedJournalEventFromJson(json);
}
