import '../../domain/domain.dart';
import '../providers/sdk_method_channel.dart';

class DataCollectionRepositoryImpl implements DataCollectionRepository {
  final SDKMethodChannel _sdkMethodChannel;

  DataCollectionRepositoryImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool?> isDataCollectionRunning() {
    return _sdkMethodChannel.isDataCollectionRunning();
  }

  @override
  void pauseDataCollection() {
    _sdkMethodChannel.pauseDataCollection();
  }

  @override
  void resumeDataCollection() {
    _sdkMethodChannel.resumeDataCollection();
  }
}
