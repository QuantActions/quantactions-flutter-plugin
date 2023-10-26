import '../../../../qa_flutter_plugin.dart';

class JournalEventMapper {
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map((dynamic json) => JournalEvent.fromJson(json as Map<String, dynamic>)).toList();
  }
}
