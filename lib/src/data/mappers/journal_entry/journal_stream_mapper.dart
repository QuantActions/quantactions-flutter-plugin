import 'dart:convert';

import '../../../domain/domain.dart';
import 'journal_entry_with_events_mapper.dart';
import 'journal_event_mapper.dart';

/// Journal Stream Mapper
class JournalStreamMapper {
  /// Get a list of journal events
  static Stream<List<JournalEvent>> getListEvent(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => JournalEventMapper.fromList(jsonDecode(event)),
    );
  }

  /// Get a list of journal entries
  static Stream<List<JournalEntry>> getListJournalEntry(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (dynamic event) => JournalEntryMapper.fromList(jsonDecode(event)),
    );
  }

  /// Check the dynamic type
  static Map<String, dynamic> checkDynamicType(dynamic json) {
    if (json is String) {
      // android
      return jsonDecode(json);
    } else {
      // ios
      return json as Map<String, dynamic>;
    }
  }
}
