import '../../../domain/models/models.dart';
import 'cohort_factory.dart';
import 'mock_model_factory.dart';
import 'questionnaire_factory.dart';

class SubscriptionWithQuestionnairesFactory
    extends MockModelFactory<QAResponse> {
  @override
  QAResponse generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse(
        data: SubscriptionWithQuestionnaires(
          cohort: CohortFactory().generateFake(),
          listOfQuestionnaires: QuestionnaireFactory().generateListFake(
            length: 3,
          ),
          subscriptionId: generateId,
          tapDeviceIds: List.generate(3, (index) => generateId),
          premiumFeaturesTTL: faker.randomGenerator.integer(999999),
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
