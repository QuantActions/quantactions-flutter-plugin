abstract class CohortProvider {
  Stream<dynamic> getCohortList();

  Future<void> leaveCohort(String cohortId);
}
