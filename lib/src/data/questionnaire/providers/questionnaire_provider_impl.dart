import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../core/sdk_method_channel.dart';
import 'questionnaire_provider.dart';

class QuestionnaireProviderImpl implements QuestionnaireProvider {
  final _eventChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/questionnaire',
  );

  final SDKMethodChannel _sdkMethodChannel;

  QuestionnaireProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream getQuestionnairesList() {
    return _sdkMethodChannel.callEventChannel(
      method: 'getQuestionnairesList',
      eventChannel: _eventChannel,
    );
  }

  @override
  Stream recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  }) {
    return _sdkMethodChannel.callEventChannel(
      method: 'recordQuestionnaireResponse',
      eventChannel: _eventChannel,
      params: <String, dynamic>{
        'name': name,
        'code': code,
        'date': date?.millisecondsSinceEpoch.toString(),
        'fullId': fullId,
        'response': response,
      },
    );
  }
}
