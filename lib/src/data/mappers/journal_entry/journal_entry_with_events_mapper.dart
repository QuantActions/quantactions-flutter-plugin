import '../../../domain/domain.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntry> fromList(List<dynamic> list) {
    return list
        .map((dynamic json) => JournalEntry.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
