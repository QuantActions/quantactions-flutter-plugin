import 'dart:convert';

import 'package:qa_flutter_plugin/src/data/mappers/qa_response/qa_response_mapper.dart';
import 'package:qa_flutter_plugin/src/domain/models/qa_response/qa_response.dart';

class QAResponseStreamMapper {
  static Stream<QAResponse<String>> getString(Stream<dynamic> stream) {
    return stream.map(
      (event) => QAResponseMapper.fromJsonString(jsonDecode(event)),
    );
  }
}
