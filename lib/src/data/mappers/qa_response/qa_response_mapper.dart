import '../../../domain/domain.dart';

class QAResponseMapper {
  static List<QAResponse<T>> fromList<T>(List<dynamic> list) {
    return list.map((json) => QAResponse<T>.fromJson(json)).toList();
  }
}
