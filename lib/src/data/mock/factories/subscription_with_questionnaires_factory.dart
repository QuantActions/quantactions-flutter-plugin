import '../../../domain/models/models.dart';
import 'cohort_factory.dart';
import 'mock_model_factory.dart';
import 'questionnaire_factory.dart';

class SubscriptionWithQuestionnairesFactory
    extends MockModelFactory<QAResponse<SubscriptionWithQuestionnaires>> {
  @override
  QAResponse<SubscriptionWithQuestionnaires> generateFake() {
    if (faker.randomGenerator.boolean()) {
      return QAResponse<SubscriptionWithQuestionnaires>(
        data: SubscriptionWithQuestionnaires(
          cohort: CohortFactory().generateFake(),
          listOfQuestionnaires: QuestionnaireFactory().generateListFake(
            length: 3,
          ),
          subscriptionId: generateId,
          tapDeviceIds: List<String>.generate(3, (int index) => generateId),
          premiumFeaturesTTL: faker.randomGenerator.integer(999999),
        ),
        message: null,
      );
    } else {
      return QAResponse<SubscriptionWithQuestionnaires>(
        data: null,
        message: faker.lorem.sentence(),
      );
    }
  }

  @override
  List<QAResponse<SubscriptionWithQuestionnaires>> generateListFake({required int length}) {
    return List<QAResponse<SubscriptionWithQuestionnaires>>.generate(
      length,
      (int index) => generateFake(),
    );
  }
}
