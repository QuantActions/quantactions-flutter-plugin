import '../../../domain/models/models.dart';
import 'mock_model_factory.dart';

/// Factory for [Cohort] model.
class CohortFactory extends MockModelFactory<Cohort> {
  @override
  Cohort generateFake([dynamic data]) {
    return Cohort(
      cohortId: generateId,
      privacyPolicy: faker.lorem.word(),
      cohortName: faker.conference.name(),
      dataPattern: faker.randomGenerator.string(10),
      canWithdraw: faker.randomGenerator.integer(2),
      permAppId: faker.randomGenerator.integer(2),
      permDrawOver: faker.randomGenerator.integer(2),
    );
  }

  @override
  List<Cohort> generateListFake({required int length}) {
    return List<Cohort>.generate(length, (int index) => generateFake());
  }
}
