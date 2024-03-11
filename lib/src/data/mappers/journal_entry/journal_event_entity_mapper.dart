import 'dart:convert';

import '../../../domain/models/journal/journal_event_entity.dart';

class JournalEventEntityMapper {
  static List<JournalEventEntity> fromList(List<dynamic> list) {
    return list.map(checkDynamicType).toList();
  }

  static JournalEventEntity checkDynamicType(dynamic json){
    if (json is String) { // android
      return JournalEventEntity.fromJson(jsonDecode(json));
    } else { // ios
      return JournalEventEntity.fromJson(json as Map<String, dynamic>);
    }
  }

}
