import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'cohort_provider.dart';

/// Cohort Provider Implementation
class CohortProviderImpl implements CohortProvider {
  final EventChannel _getCohortListEventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_cohort_list',
  );

  final SDKMethodChannel _sdkMethodChannel;

  /// Cohort Provider Implementation constructor
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
  Future<void> leaveCohort(String subscriptionId, String cohortId) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.leaveCohort,
      params: <String, dynamic>{
        'subscriptionId': subscriptionId,
        'cohortId': cohortId,
      },
    );
  }
}
