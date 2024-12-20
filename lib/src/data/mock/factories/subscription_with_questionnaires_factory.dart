import '../../../domain/models/models.dart';
import 'cohort_factory.dart';
import 'mock_model_factory.dart';
import 'questionnaire_factory.dart';

/// Factory for [SubscriptionWithQuestionnaires] model.
class SubscriptionWithQuestionnairesFactory
    extends MockModelFactory<SubscriptionWithQuestionnaires> {
  @override
  SubscriptionWithQuestionnaires generateFake([dynamic data]) {
    return SubscriptionWithQuestionnaires(
      cohort: CohortFactory().generateFake(),
      listOfQuestionnaires: QuestionnaireFactory().generateListFake(
        length: 3,
      ),
      subscriptionId: generateId,
      tapDeviceIds: List<String>.generate(3, (int index) => generateId),
      premiumFeaturesTTL: faker.randomGenerator.integer(999999),
    );
  }

  @override
  List<SubscriptionWithQuestionnaires> generateListFake({required int length}) {
    return List<SubscriptionWithQuestionnaires>.generate(
      length,
      (int index) => generateFake(),
    );
  }
}
