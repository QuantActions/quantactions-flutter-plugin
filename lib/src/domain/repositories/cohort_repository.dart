import '../models/cohort/cohort.dart';
import '../models/qa_response/qa_response.dart';

abstract class CohortRepository {
  Stream<List<Cohort>> getCohortList();

  Stream<QAResponse<String>> leaveCohort(String cohortId);
}
