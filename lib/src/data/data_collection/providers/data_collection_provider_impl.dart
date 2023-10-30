import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'data_collection_provider.dart';

class DataCollectionProviderImpl implements DataCollectionProvider {
  final MethodChannel _dataCollectionRunningMethodChannel = const MethodChannel(
    '${MethodChannelConsts.mainMethodChannel}/data_collection_running',
  );

  final SDKMethodChannel _sdkMethodChannel;

  DataCollectionProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Future<bool> isDataCollectionRunning() {
    return _sdkMethodChannel.callMethodChannel<bool>(
      method: SupportedMethods.isDataCollectionRunning,
      methodChannel: _dataCollectionRunningMethodChannel,
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
