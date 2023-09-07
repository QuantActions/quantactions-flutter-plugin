import '../../../domain/domain.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntryWithEvents> fromList(List<dynamic> list) {
    return list
        .map((dynamic json) => JournalEntryWithEvents.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
