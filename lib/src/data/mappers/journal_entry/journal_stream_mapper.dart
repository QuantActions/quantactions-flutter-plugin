import 'dart:convert';

import '../../../domain/domain.dart';
import 'journal_entry_with_events_mapper.dart';
import 'journal_event_mapper.dart';

class JournalStreamMapper {
  static Stream<List<JournalEvent>> getListEvent(Stream<dynamic> stream) {
    return stream.map(
      (event) => JournalEventMapper.fromList(jsonDecode(event)),
    );
  }

  static Stream<List<JournalEntryWithEvents>> getListEntryWithEvents(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (event) => JournalEntryWithEventsMapper.fromList(jsonDecode(event)),
    );
  }
}
