import '../../../../qa_flutter_plugin.dart';
import 'resolved_journal_event_mapper.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntryWithEvents> fromList(List<dynamic> list) {
    return list.map((dynamic map) => fromJson(map as Map<String, dynamic>)).toList();
  }

  static JournalEntryWithEvents fromJson(Map<String, dynamic> map) {
    return JournalEntryWithEvents(
      id: map['id'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      note: map['note'] as String,
      events: (map['events'] as List<dynamic>)
          .map((dynamic item) => ResolvedJournalEventMapper.fromJson(item as Map<String, dynamic>))
          .toList(),
      ratings: (map['ratings'] as List<dynamic>).map((dynamic rating) => rating as int).toList(),
      scores: (map['scores'] as Map<String, dynamic>).map(
        (String key, dynamic value) => MapEntry<String, int>(key, value as int),
      ),
    );
  }
}
