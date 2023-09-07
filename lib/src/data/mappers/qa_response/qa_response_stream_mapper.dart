import 'dart:convert';

import '../../../domain/domain.dart';
import 'qa_response_mapper.dart';

class QAResponseStreamMapper {
  static Stream<QAResponse<String>> getString(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => QAResponseMapper.fromJsonString(jsonDecode(event)),
    );
  }

  static Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionIdResponse(
    Stream<dynamic> stream,
  ) {
    return stream.map(
      (dynamic event) => QAResponseMapper.fromJsonSubscriptionIdResponse(
        jsonDecode(event),
      ),
    );
  }
}
