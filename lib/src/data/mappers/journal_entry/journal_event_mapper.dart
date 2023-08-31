import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

class JournalEventMapper {
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map((json) =>JournalEvent.fromJson(json)).toList();
  }
}
