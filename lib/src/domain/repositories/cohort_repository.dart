import '../models/cohort/cohort.dart';

abstract class CohortRepository {
  Stream<List<Cohort>> getCohortList();

  Future<void> leaveCohort(String cohortId);
}
