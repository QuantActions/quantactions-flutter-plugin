import '../../consts/supported_methods.dart';
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
      method: SupportedMethods.isDataCollectionRunning,
    );
  }

  @override
  Future<void> pauseDataCollection() async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.pauseDataCollection,
    );
  }

  @override
  Future<void> resumeDataCollection() async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.resumeDataCollection,
    );
  }
}
