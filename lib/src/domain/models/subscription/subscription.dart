import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  final String id;
  final List<String> deviceIds;
  final String cohortId;
  final String cohortName;
  final int premiumFeaturesTTL;

  Subscription({
    required this.id,
    required this.deviceIds,
    required this.cohortId,
    required this.cohortName,
    required this.premiumFeaturesTTL,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
