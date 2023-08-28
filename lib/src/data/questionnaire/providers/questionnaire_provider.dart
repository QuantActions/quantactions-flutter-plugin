abstract class QuestionnaireProvider {
  Stream<dynamic> getQuestionnairesList();

  Stream<dynamic> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
