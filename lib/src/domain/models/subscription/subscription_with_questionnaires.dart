import 'package:json_annotation/json_annotation.dart';

import '../../domain.dart';

part 'subscription_with_questionnaires.g.dart';

@JsonSerializable()
class SubscriptionWithQuestionnaires {
  final Cohort cohort;
  final List<Questionnaire> listOfQuestionnaires;
  final String subscriptionId;
  final List<String> tapDeviceIds;
  final int premiumFeaturesTTL;

  SubscriptionWithQuestionnaires({
    required this.cohort,
    required this.listOfQuestionnaires,
    required this.subscriptionId,
    required this.tapDeviceIds,
    required this.premiumFeaturesTTL,
  });

  factory SubscriptionWithQuestionnaires.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionWithQuestionnairesFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionWithQuestionnairesToJson(this);
}
