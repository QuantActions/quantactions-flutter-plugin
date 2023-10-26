import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'qa_response.g.dart';

@JsonSerializable()
class QAResponse<T> {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final T? data;
  final String? message;

  QAResponse({
    required this.data,
    required this.message,
  });

  factory QAResponse.fromJson(Map<String, dynamic> json) =>
      _$QAResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$QAResponseToJson<T>(this);

  static T? _dataFromJson<T>(dynamic json) {
    return _QAResponseConverter<T>().fromJson(json);
  }

  static dynamic _dataToJson<T>(T? object) {
    return _QAResponseConverter<T>().toJson(object);
  }
}

class _QAResponseConverter<T> implements JsonConverter<T?, dynamic> {
  _QAResponseConverter();

  @override
  T? fromJson(dynamic json) {
    if (json == null) {
      return null;
    } else if (T == SubscriptionIdResponse) {
      return SubscriptionIdResponse.fromJson(json) as T?;
    } else if (T == SubscriptionWithQuestionnaires) {
      return SubscriptionWithQuestionnaires.fromJson(json) as T?;
    } else if (T == String) {
      return json as T?;
    }

    return null;
  }

  @override
  dynamic toJson(T? object) {
    if (object == null) return null;

    if (T is SubscriptionIdResponse) {
      return (object as SubscriptionIdResponse).toJson();
    } else if (T is SubscriptionWithQuestionnaires) {
      return (object as SubscriptionWithQuestionnaires).toJson();
    } else {
      return object;
    }
  }
}
