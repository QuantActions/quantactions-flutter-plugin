import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'subscription_with_questionnaires.g.dart';

/// Class containing the information about a cohort and all of its questionnaires.
@JsonSerializable()
class SubscriptionWithQuestionnaires {
  /// The cohort associated with the subscription
  final Cohort cohort;

  /// the list of [Questionnaire]s associated with the cohort
  final List<Questionnaire> listOfQuestionnaires;

  /// the id of the subscription (a.k.a. participationID)
  final String subscriptionId;

  /// the list of device ids associated with the subscription
  final List<String> tapDeviceIds;

  /// the time to live of the premium features associated with the subscription
  final int premiumFeaturesTTL;

  /// Constructor
  SubscriptionWithQuestionnaires({
    required this.cohort,
    required this.listOfQuestionnaires,
    required this.subscriptionId,
    required this.tapDeviceIds,
    required this.premiumFeaturesTTL,
  });

  /// Create a [SubscriptionWithQuestionnaires] from a json
  factory SubscriptionWithQuestionnaires.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionWithQuestionnairesFromJson(json);

  /// Convert the [SubscriptionWithQuestionnaires] to a json
  Map<String, dynamic> toJson() => _$SubscriptionWithQuestionnairesToJson(this);
}
