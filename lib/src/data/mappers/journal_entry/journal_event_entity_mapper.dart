import 'dart:convert';

import '../../../domain/models/journal/journal_event_entity.dart';

/// Journal Event Entity Mapper
class JournalEventEntityMapper {
  /// List from a stream
  static List<JournalEventEntity> fromList(List<dynamic> list) {
    return list.map(checkDynamicType).toList();
  }

  /// Check the dynamic type
  static JournalEventEntity checkDynamicType(dynamic json) {
    if (json is String) {
      // android
      return JournalEventEntity.fromJson(jsonDecode(json));
    } else {
      // ios
      return JournalEventEntity.fromJson(json as Map<String, dynamic>);
    }
  }
}
