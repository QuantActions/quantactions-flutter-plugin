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
  void pauseDataCollection() {
    _dataCollectionProvider.pauseDataCollection();
  }

  @override
  void resumeDataCollection() {
    _dataCollectionProvider.resumeDataCollection();
  }
}
