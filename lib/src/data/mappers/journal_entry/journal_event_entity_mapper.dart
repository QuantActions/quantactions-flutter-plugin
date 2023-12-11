import '../../../domain/models/journal/journal_event_entity.dart';

class JournalEventEntityMapper {
  static List<JournalEventEntity> fromList(List<dynamic> list) {
    return list.map((dynamic json) => JournalEventEntity.fromJson(json as Map<String, dynamic>)).toList();
  }
}
