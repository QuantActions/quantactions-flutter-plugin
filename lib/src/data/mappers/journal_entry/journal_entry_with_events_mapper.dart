import 'dart:convert';

import '../../../domain/domain.dart';

class JournalEntryMapper {
  static List<JournalEntry> fromList(List<dynamic> list) {
    return list
        .map(checkDynamicType)
        .toList();
  }

  static JournalEntry checkDynamicType(dynamic json){
    if (json is String) { // android
      return JournalEntry.fromJson(jsonDecode(json));
    } else { // ios
      return JournalEntry.fromJson(json as Map<String, dynamic>);
    }
  }

}
