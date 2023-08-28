import '../../../domain/domain.dart';

class SubscriptionIdResponseMapper {
  static SubscriptionIdResponse fromJson(Map<String, dynamic> map) {
    return SubscriptionIdResponse(
      subscriptionId: map['subscriptionId'] as String,
      deviceIds: map['deviceIds'] as List<String>,
      cohortId: map['cohortId'] as String,
    );
  }
}
