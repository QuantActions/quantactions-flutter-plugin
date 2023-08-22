import 'package:qa_flutter_plugin/src/domain/models/qa_response/qa_response.dart';

import '../../../domain/domain.dart';

class QAResponseMapper {
  static const String _data = 'data';
  static const String _message = 'message';

  static QAResponse<String> fromJsonString(Map<String, dynamic> json) {
    return QAResponse<String>(
      data: json[_data] as String?,
      message: json[_message] as String?,
    );
  }
}
