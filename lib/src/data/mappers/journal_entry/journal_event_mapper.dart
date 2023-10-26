import '../../../../qa_flutter_plugin.dart';
import '../../error_handler/mapper_wrapper.dart';

class JournalEventMapper {
  static List<JournalEvent> fromList(List<dynamic> list) {
    return list.map((dynamic json) {
      return MapperWrapper.handleErrors<JournalEvent>(
        data: json,
        mapper: () => JournalEvent.fromJson(json as Map<String, dynamic>),
      );
    }).toList();
  }
}
