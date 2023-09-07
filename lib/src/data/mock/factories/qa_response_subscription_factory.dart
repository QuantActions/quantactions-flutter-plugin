import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class QAResponseSubscriptionFactory extends MockModelFactory<QAResponse<SubscriptionIdResponse>> {
  @override
  QAResponse<SubscriptionIdResponse> generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse<SubscriptionIdResponse>(
        data: SubscriptionIdResponse(
          subscriptionId: generateId,
          deviceIds: List<String>.generate(3, (int index) => generateId),
          cohortId: generateId,
        ),
        message: null,
      );
    } else {
      return QAResponse<SubscriptionIdResponse>(
        data: null,
        message: faker.lorem.sentence(),
      );
    }
  }

  @override
  List<QAResponse<SubscriptionIdResponse>> generateListFake({required int length}) {
    return List<QAResponse<SubscriptionIdResponse>>.generate(length, (int index) => generateFake());
  }
}
