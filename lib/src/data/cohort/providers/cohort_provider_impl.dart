import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'cohort_provider.dart';

class CohortProviderImpl implements CohortProvider {
  final _getCohortListEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_cohort_list',
  );
  final _leaveCohortEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/leave_cohort',
  );

  final SDKMethodChannel _sdkMethodChannel;

  CohortProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getCohortList() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getCohortList,
      eventChannel: _getCohortListEventChannel,
    );
  }

  @override
  Stream<dynamic> leaveCohort(String cohortId) {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.leaveCohort,
      eventChannel: _leaveCohortEventChannel,
      params: <String, dynamic>{
        'cohortId': cohortId,
      },
    );
  }
}
