import '../../../domain/domain.dart';

class ResolvedJournalEventMapper {
  static ResolvedJournalEvent fromJson(Map<String, dynamic> map) {
    return ResolvedJournalEvent(
      id: map['id'] as String,
      publicName: map['publicName'] as String,
      iconName: map['iconName'] as String,
    );
  }
}
