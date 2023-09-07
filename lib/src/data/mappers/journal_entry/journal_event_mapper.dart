import '../../../../qa_flutter_plugin.dart';

class JournalEventMapper {
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map((dynamic map) => fromJson(map as Map<String, dynamic>)).toList();
  }

  static JournalEvent fromJson(Map<String, dynamic> map) {
    return JournalEvent(
      id: map['id'] as String,
      publicName: map['publicName'] as String,
      iconName: map['iconName'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      modified: DateTime.fromMillisecondsSinceEpoch(map['modified'] as int),
    );
  }
}
