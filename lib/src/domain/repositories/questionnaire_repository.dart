import '../models/models.dart';

abstract class QuestionnaireRepository {
  Stream<List<Questionnaire>> getQuestionnairesList();

  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
