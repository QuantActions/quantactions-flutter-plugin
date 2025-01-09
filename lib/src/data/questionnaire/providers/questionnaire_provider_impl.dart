import 'package:flutter/services.dart';

import '../../consts/method_channel_consts.dart';
import '../../consts/supported_methods.dart';
import '../../core/sdk_method_channel.dart';
import 'questionnaire_provider.dart';

/// Implementation of [QuestionnaireProvider].
class QuestionnaireProviderImpl implements QuestionnaireProvider {
  final EventChannel _getQuestionnairesListChannel = const EventChannel(
    '${MethodChannelConsts.eventMethodChannelPrefix}/get_questionnaires_list',
  );

  final SDKMethodChannel _sdkMethodChannel;

  /// Constructor for [QuestionnaireProviderImpl].
  QuestionnaireProviderImpl({
    required SDKMethodChannel sdkMethodChannel,
  }) : _sdkMethodChannel = sdkMethodChannel;

  @override
  Stream<dynamic> getQuestionnairesList() {
    return _sdkMethodChannel.callEventChannel(
      method: SupportedMethods.getQuestionnairesList,
      eventChannel: _getQuestionnairesListChannel,
    );
  }

  @override
  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  }) async {
    await _sdkMethodChannel.callMethodChannel(
      method: SupportedMethods.recordQuestionnaireResponse,
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
