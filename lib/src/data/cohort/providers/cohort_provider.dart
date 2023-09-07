abstract class CohortProvider {
  Stream<dynamic> getCohortList();

  Stream<dynamic> leaveCohort(String cohortId);
}
