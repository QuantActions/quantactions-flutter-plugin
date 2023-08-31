import '../../../domain/domain.dart';

class QAResponseMapper {
  static const String _data = 'data';
  static const String _message = 'message';

  static List<QAResponse<String>> fromList(List<dynamic> list) {
    return list.map((map) => fromJsonString(map)).toList();
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
    Map<String, dynamic>? data = json[_data];

    return QAResponse<SubscriptionIdResponse>(
      data: (data == null)
          ? null
          : SubscriptionIdResponse.fromJson(json[_data]),
      message: json[_message] as String?,
    );
  }
}
