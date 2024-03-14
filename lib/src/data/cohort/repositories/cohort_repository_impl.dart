import '../../../domain/domain.dart';
import '../../mappers/cohort/cohort_mapper.dart';
import '../providers/cohort_provider.dart';

class CohortRepositoryImpl implements CohortRepository {
  final CohortProvider _cohortProvider;

  CohortRepositoryImpl({
    required CohortProvider cohortProvider,
  }) : _cohortProvider = cohortProvider;

  @override
  Stream<List<Cohort>> getCohortList() {
    final Stream<dynamic> stream = _cohortProvider.getCohortList();

    return CohortMapper.listFromStream(stream);
  }

  @override
  Future<void> leaveCohort(String subscriptionId, String cohortId) async {
    await _cohortProvider.leaveCohort(subscriptionId, cohortId);
  }
}
