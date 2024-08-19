import '../../../domain/domain.dart';
import 'mock_model_factory.dart';

class QuestionnaireFactory extends MockModelFactory<Questionnaire> {
  @override
  Questionnaire generateFake([dynamic data]) {
    return Questionnaire(
      id: generateId,
      questionnaireName: faker.conference.name(),
      questionnaireDescription: faker.lorem.sentences(2).join(),
      questionnaireCode: faker.lorem.word(),
      questionnaireCohort: faker.conference.name(),
      questionnaireBody: faker.lorem.sentences(5).join(),
    );
  }

  @override
  List<Questionnaire> generateListFake({required int length}) {
    return List<Questionnaire>.generate(length, (int index) => generateFake());
  }
}
