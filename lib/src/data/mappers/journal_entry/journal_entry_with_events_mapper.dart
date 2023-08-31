import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntryWithEvents> fromList(List<dynamic> list) {
    return list.map((json) => JournalEntryWithEvents.fromJson(json)).toList();
  }
}
