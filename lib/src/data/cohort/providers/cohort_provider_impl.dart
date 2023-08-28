import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../core/sdk_method_channel.dart';
import 'cohort_provider.dart';

class CohortProviderImpl implements CohortProvider {
  final _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/cohort',
  );

  final SDKMethodChannel _sdkMethodChannel;

  CohortProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getCohortList() {
    return _sdkMethodChannel.callEventChannel(
      method: 'getCohortList',
      eventChannel: _eventChannel,
    );
  }

  @override
  Stream<dynamic> leaveCohort(String cohortId) {
    return _sdkMethodChannel.callEventChannel(
      method: 'leaveCohort',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'cohortId': cohortId,
      },
    );
  }
}