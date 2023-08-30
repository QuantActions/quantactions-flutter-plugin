import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntryWithEvents> fromList(List<dynamic> list) {
    return list.map((map) => fromJson(map)).toList();
  }

  static JournalEntryWithEvents fromJson(Map<String, dynamic> map) {
    return JournalEntryWithEvents(
      id: map["id"] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"] as int),
      note: map["note"] as String,
      events: (map["events"] as List<dynamic>)
          .map((event) => ResolvedJournalEvent.fromJson(event))
          .toList(),
      ratings: (map["ratings"] as List<dynamic>)
          .map((rating) => rating as int)
          .toList(),
      scores: (map["scores"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as int),
      ),
    );
  }
}
