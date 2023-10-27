import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'cohort_provider.dart';

class CohortProviderImpl implements CohortProvider {
  final EventChannel _getCohortListEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_cohort_list',
  );
  final MethodChannel _leaveCohortMethodChannel = const MethodChannel(
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
  Future<void> leaveCohort(String cohortId) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.leaveCohort,
      methodChannel: _leaveCohortMethodChannel,
      params: <String, dynamic>{
        'cohortId': cohortId,
      },
    );
  }
}
