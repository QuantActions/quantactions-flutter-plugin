/// Abstract class for CohortProvider
abstract class CohortProvider {
  /// Get list of cohorts the user is subscribed to.
  Stream<dynamic> getCohortList();

  /// Un-subscribe the user from a cohort.
  Future<void> leaveCohort(String subscriptionId, String cohortId);
}
