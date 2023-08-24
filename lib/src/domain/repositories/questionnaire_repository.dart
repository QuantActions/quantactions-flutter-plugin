import '../models/cohort/cohort.dart';
import '../models/qa_response/qa_response.dart';

abstract class QuestionnaireRepository {
  Stream<List<Cohort>> getQuestionnairesList();

  Stream<QAResponse<String>> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  });
}
