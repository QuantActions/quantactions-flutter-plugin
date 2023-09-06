import '../../core/sdk_method_channel.dart';
import 'data_collection_provider.dart';

class DataCollectionProviderImpl implements DataCollectionProvider {
  final SDKMethodChannel _sdkMethodChannel;

  DataCollectionProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> isDataCollectionRunning() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: 'isDataCollectionRunning',
    );
  }

  @override
  Future<void> pauseDataCollection() async {
    _sdkMethodChannel.callMethodChannel(method: 'pauseDataCollection');
  }

  @override
  Future<void> resumeDataCollection() async {
    _sdkMethodChannel.callMethodChannel(method: 'resumeDataCollection');
  }
}
