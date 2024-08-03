import 'dart:convert';

import '../../../../quantactions_flutter_plugin.dart';

class JournalEventMapper {
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map(checkDynamicType).toList();
  }

  static JournalEvent checkDynamicType(dynamic json){
    if (json is String) { // android
      return JournalEvent.fromJson(jsonDecode(json));
    } else { // ios
      return JournalEvent.fromJson(json as Map<String, dynamic>);
    }
  }
}
