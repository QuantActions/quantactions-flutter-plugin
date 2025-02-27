/// Interface for the QuestionnaireProvider
abstract class QuestionnaireProvider {
  /// Gets a list of questionnaires.
  Stream<dynamic> getQuestionnairesList();

  /// Records a questionnaire response.
  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
