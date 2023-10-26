import '../../../domain/domain.dart';
import '../../error_handler/mapper_wrapper.dart';

class JournalEntryWithEventsMapper {
  static List<JournalEntryWithEvents> fromList(List<dynamic> list) {
    return list.map((dynamic json) {
      return MapperWrapper.handleErrors<JournalEntryWithEvents>(
        data: json,
        mapper: () => JournalEntryWithEvents.fromJson(json as Map<String, dynamic>),
      );
    }).toList();
  }
}
