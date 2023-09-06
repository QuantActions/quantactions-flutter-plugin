import '../../../domain/domain.dart';
import '../providers/data_collection_provider.dart';

class DataCollectionRepositoryImpl implements DataCollectionRepository {
  final DataCollectionProvider _dataCollectionProvider;

  DataCollectionRepositoryImpl({
    required DataCollectionProvider dataCollectionProvider,
  }) : _dataCollectionProvider = dataCollectionProvider;

  @override
  Future<bool> isDataCollectionRunning() {
    return _dataCollectionProvider.isDataCollectionRunning();
  }

  @override
  Future<void> pauseDataCollection() async {
    await _dataCollectionProvider.pauseDataCollection();
  }

  @override
  Future<void> resumeDataCollection() async {
    _dataCollectionProvider.resumeDataCollection();
  }
}
