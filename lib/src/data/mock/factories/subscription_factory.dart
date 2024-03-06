import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class SubscriptionFactory extends MockModelFactory<Subscription> {
  @override
  Subscription generateFake([dynamic data]) {
    return Subscription(
      subscriptionId: generateId,
      deviceIds: List<String>.generate(3, (int index) => generateId),
      cohortId: generateId,
      cohortName: faker.conference.name(),
      premiumFeaturesTTL: faker.randomGenerator.integer(50),
      token: "ABCDEFGJH",

    );
  }

  @override
  List<Subscription> generateListFake({required int length}) {
    return List<Subscription>.generate(length, (int index) => generateFake());
  }
}
