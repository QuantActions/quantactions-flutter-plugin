class SubscriptionIdResponse {
  final String subscriptionId;
  final List<String> deviceIds;
  final String cohortId;

  SubscriptionIdResponse({
    required this.subscriptionId,
    required this.deviceIds,
    required this.cohortId,
  });
}
