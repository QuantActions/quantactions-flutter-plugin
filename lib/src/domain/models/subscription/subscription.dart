import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

/// This object hold the information about a subscription. It returns the
/// subscriptionId, the list of deviceIds connected to this subscription and the cohortId relative to
/// the subscription.
///
@JsonSerializable()
class Subscription {
  /// The subscription id
  final String subscriptionId;

  /// The list of device ids associated with the subscription
  final List<String> deviceIds;

  /// The cohort id associated with the subscription
  final String cohortId;

  /// The cohort name associated with the subscription
  final String cohortName;

  /// The time to live of the premium features associated with the subscription
  final int premiumFeaturesTTL;

  /// The token associated with the subscription (a.k.a. voucher)
  final String? token;

  /// Constructor
  Subscription(
      {required this.subscriptionId,
      required this.deviceIds,
      required this.cohortId,
      required this.cohortName,
      required this.premiumFeaturesTTL,
      required this.token});

  /// Create a [Subscription] from a json
  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  /// Convert the [Subscription] to a json
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
