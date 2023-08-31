import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class QAResponseSubscriptionFactory extends MockModelFactory<QAResponse> {
  @override
  QAResponse generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse(
        data: SubscriptionIdResponse(
          subscriptionId: generateId,
          deviceIds: List.generate(3, (index) => generateId),
          cohortId: generateId,
        ),
        message: null,
      );
    } else {
      return QAResponse(
        data: null,
        message: faker.lorem.sentence(),
      );
    }
  }

  @override
  List<QAResponse> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
