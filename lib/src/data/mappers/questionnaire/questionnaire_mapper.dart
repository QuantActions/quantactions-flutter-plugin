import 'package:qa_flutter_plugin/src/domain/domain.dart';

class QuestionnaireMapper {
  static List<Questionnaire> fromList(List<dynamic> list) {
    return list.map((map) => fromJson(map)).toList();
  }

  static Questionnaire fromJson(Map<String, dynamic> map) {
    return Questionnaire(
      id: map['id'] as String,
      questionnaireName: map['questionnaireName'] as String,
      questionnaireDescription: map['questionnaireDescription'] as String,
      questionnaireCode: map['questionnaireCode'] as String,
      questionnaireCohort: map['questionnaireCohort'] as String,
      questionnaireBody: map['questionnaireBody'] as String,
    );
  }
}
