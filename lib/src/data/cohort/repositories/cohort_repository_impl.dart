import '../../../domain/domain.dart';
import '../../mappers/cohort/cohort_stream_mapper.dart';
import '../../mappers/qa_response/qa_response_stream_mapper.dart';
import '../providers/cohort_provider.dart';

class CohortRepositoryImpl implements CohortRepository {
  final CohortProvider _cohortProvider;

  CohortRepositoryImpl({
    required CohortProvider cohortProvider,
  }) : _cohortProvider = cohortProvider;

  @override
  Stream<List<Cohort>> getCohortList() {
    final stream = _cohortProvider.getCohortList();

    return CohortStreamMapper.getList(stream);
  }

  @override
  Stream<QAResponse<String>> leaveCohort(String cohortId) {
    final stream = _cohortProvider.leaveCohort(cohortId);

    return QAResponseStreamMapper.getString(stream);
  }
}
