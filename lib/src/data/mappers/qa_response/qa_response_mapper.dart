import '../../../domain/domain.dart';
import 'subscription_id_response_mapper.dart';

class QAResponseMapper {
  static const String _data = 'data';
  static const String _message = 'message';

  static List<QAResponse<String>> fromList(List<dynamic> list) {
    return list.map((dynamic map) => fromJsonString(map as Map<String, dynamic>)).toList();
  }

  static QAResponse<String> fromJsonString(Map<String, dynamic> json) {
    return QAResponse<String>(
      data: json[_data] as String?,
      message: json[_message] as String?,
    );
  }

  static QAResponse<SubscriptionIdResponse> fromJsonSubscriptionIdResponse(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic>? data = json[_data];

    return QAResponse<SubscriptionIdResponse>(
      data: (data == null) ? null : SubscriptionIdResponseMapper.fromJson(json[_data]),
      message: json[_message] as String?,
    );
  }
}
