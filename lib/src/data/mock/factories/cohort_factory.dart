import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';
import 'package:qa_flutter_plugin/src/data/mock/factories/mock_model_factory.dart';

class CohortFactory extends MockModelFactory<Cohort> {
  @override
  Cohort generateFake() {
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
  List<Cohort> generateListFake({
    required int length,
  }) {
    return List.generate(length, (index) => generateFake());
  }
}
