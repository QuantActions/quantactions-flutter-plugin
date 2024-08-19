abstract class QuestionnaireProvider {
  Stream<dynamic> getQuestionnairesList();

  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
