import 'dart:async';
import 'dart:convert';

import 'package:qa_flutter_plugin/src/data/mock/factories/qa_response_subscription_factory.dart';

import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';
import 'factories/journal_event_factory.dart';
import 'factories/qa_response_string_factory.dart';

class MockDataProvider {
  static dynamic callMockMethod(String method) {
    switch (method) {
      //methods for method channel
      case SupportedMethods.getBasicInfo:
        return jsonEncode(
          BasicInfoFactory().generateFake(),
        );
      case SupportedMethods.getDeviceID:
      // TODO: Handle this case.
      case SupportedMethods.getFirebaseToken:
      // TODO: Handle this case.
      case SupportedMethods.getIsTablet:
      // TODO: Handle this case.
      case SupportedMethods.isDataCollectionRunning:
      // TODO: Handle this case.
      case SupportedMethods.resumeDataCollection:
      // TODO: Handle this case.
      case SupportedMethods.pauseDataCollection:
      // TODO: Handle this case.
      case SupportedMethods.isDeviceRegistered:
      // TODO: Handle this case.
      case SupportedMethods.syncData:
      // TODO: Handle this case.
      case SupportedMethods.getSubscriptionIdAsync:
        return Future(() => _getQAResponseSubscriptionIdResponse());
      case SupportedMethods.getJournalEntry:
      // TODO: Handle this case.
      case SupportedMethods.getMetricAsync:
      // TODO: Handle this case.
      case SupportedMethods.getStatSampleAsync:
      // TODO: Handle this case.
      case SupportedMethods.canDraw:
      // TODO: Handle this case.
      case SupportedMethods.canUsage:
      // TODO: Handle this case.
      case SupportedMethods.isInit:
      // TODO: Handle this case.
      case SupportedMethods.initAsync:
      // TODO: Handle this case.
      case SupportedMethods.updateBasicInfo:
      // TODO: Handle this case.
      case SupportedMethods.savePublicKey:
      // TODO: Handle this case.
      case SupportedMethods.setVerboseLevel:
      // TODO: Handle this case.

      //methods for event channel
      case SupportedMethods.getCohortList:
        return Stream.value(
          jsonEncode(
            CohortFactory()
                .generateListFake(length: 10)
                .map((cohort) => cohort.toJson())
                .toList(),
          ),
        );
      case SupportedMethods.leaveCohort:
        return _getQAResponseString();
      case SupportedMethods.redeemVoucher:
        return _getQAResponseString();
      case SupportedMethods.subscribeWithGooglePurchaseToken:
        return _getQAResponseString();
      case SupportedMethods.subscribe:
        return _getQAResponseString();
      case SupportedMethods.getSubscriptionId:
        return Stream.value(_getQAResponseSubscriptionIdResponse());
      case SupportedMethods.createJournalEntry:
        return _getQAResponseString();
      case SupportedMethods.deleteJournalEntry:
        return _getQAResponseString();
      case SupportedMethods.sendNote:
        return _getQAResponseString();
      case SupportedMethods.getJournal:
        return _getJournalEntryWithEventsList(length: 10);
      case SupportedMethods.getJournalSample:
        return _getJournalEntryWithEventsList(length: 10);
      case SupportedMethods.getJournalEvents:
        return Stream.value(
          jsonEncode(
            JournalEventFactory()
                .generateListFake(length: 10)
                .map((cohort) => cohort.toJson())
                .toList(),
          ),
        );
      case SupportedMethods.getMetric:
      // TODO: Handle this case.
      case SupportedMethods.getMetricSample:
      // TODO: Handle this case.
      case SupportedMethods.getQuestionnairesList:
      // TODO: Handle this case.
      case SupportedMethods.recordQuestionnaireResponse:
        return _getQAResponseString();
      case SupportedMethods.init:
        return _getQAResponseString();
      case SupportedMethods.validateToken:
        return _getQAResponseString();
      default:
        throw Exception('$method mock method is not implemented');
    }
  }

  static Stream<String> _getJournalEntryWithEventsList({
    required int length,
  }) {
    return Stream.value(
      jsonEncode(
        JournalEventFactory()
            .generateListFake(length: 10)
            .map((cohort) => cohort.toJson())
            .toList(),
      ),
    );
  }

  static Stream<String> _getQAResponseString() {
    return Stream.value(
      jsonEncode(
        QAResponseStringFactory().generateFake(),
      ),
    );
  }

  static String _getQAResponseSubscriptionIdResponse() {
    final x = QAResponseSubscriptionFactory().generateFake();
    return jsonEncode(x);
  }
}
