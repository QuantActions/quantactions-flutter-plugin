import 'package:qa_flutter_plugin/src/domain/domain.dart';

class QuestionnaireMapper {
  static List<Questionnaire> fromList(List<dynamic> list) {
    return list.map((json) => Questionnaire.fromJson(json)).toList();
  }
}
