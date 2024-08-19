import '../models/cohort/cohort.dart';

/// Cohort Repository
abstract class CohortRepository {
  /// Get list of cohorts the user is subscribed to.
  Stream<List<Cohort>> getCohortList();

  /// Un-subscribe the user from a cohort.
  Future<void> leaveCohort(String subscriptionId, String cohortId);
}
