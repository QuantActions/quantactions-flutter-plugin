import '../models/models.dart';

abstract class QuestionnaireRepository {
  Stream<List<Questionnaire>> getQuestionnairesList();

  Stream<QAResponse<String>> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
