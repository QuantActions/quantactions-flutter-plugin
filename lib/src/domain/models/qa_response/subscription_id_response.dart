import 'package:json_annotation/json_annotation.dart';

part 'subscription_id_response.g.dart';

@JsonSerializable()
class SubscriptionIdResponse {
  final String subscriptionId;
  final List<String> deviceIds;
  final String cohortId;

  SubscriptionIdResponse({
    required this.subscriptionId,
    required this.deviceIds,
    required this.cohortId,
  });

  factory SubscriptionIdResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionIdResponseToJson(this);
}
