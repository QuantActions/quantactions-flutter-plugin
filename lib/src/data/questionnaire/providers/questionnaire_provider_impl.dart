import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'questionnaire_provider.dart';

class QuestionnaireProviderImpl implements QuestionnaireProvider {
  final _getQuestionnairesListChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_questionnaires_list',
  );
  final _recordQuestionnaireResponseChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/record_questionnaire_response',
  );

  final SDKMethodChannel _sdkMethodChannel;

  QuestionnaireProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream getQuestionnairesList() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getQuestionnairesList,
      eventChannel: _getQuestionnairesListChannel,
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
      method: SupportedMethods.recordQuestionnaireResponse,
      eventChannel: _recordQuestionnaireResponseChannel,
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
