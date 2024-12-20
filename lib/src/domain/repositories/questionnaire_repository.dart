import '../models/models.dart';

/// Abstract class for Questionnaire repository.
abstract class QuestionnaireRepository {
  /// Get a list of questionnaires.
  Stream<List<Questionnaire>> getQuestionnairesList();

  /// Record a questionnaire response.
  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
