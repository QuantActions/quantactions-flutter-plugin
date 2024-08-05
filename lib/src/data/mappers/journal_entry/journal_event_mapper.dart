import 'dart:convert';

import '../../../../quantactions_flutter_plugin.dart';

/// Journal Event Mapper
class JournalEventMapper {
  /// List from a stream
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map(checkDynamicType).toList();
  }

  /// Check the dynamic type
  static JournalEvent checkDynamicType(dynamic json) {
    if (json is String) {
      // android
      return JournalEvent.fromJson(jsonDecode(json));
    } else {
      // ios
      return JournalEvent.fromJson(json as Map<String, dynamic>);
    }
  }
}
