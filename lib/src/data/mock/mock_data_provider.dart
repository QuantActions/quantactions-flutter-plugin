import 'dart:async';
import 'dart:convert';

import 'package:qa_flutter_plugin/src/data/mock/factories/journal_event_factory.dart';

import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';

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
      // TODO: Handle this case.
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
      // TODO: Handle this case.
      case SupportedMethods.redeemVoucher:
      // TODO: Handle this case.
      case SupportedMethods.subscribeWithGooglePurchaseToken:
      // TODO: Handle this case.
      case SupportedMethods.subscribe:
      // TODO: Handle this case.
      case SupportedMethods.getSubscriptionId:
      // TODO: Handle this case.
      case SupportedMethods.createJournalEntry:
      // TODO: Handle this case.
      case SupportedMethods.deleteJournalEntry:
      // TODO: Handle this case.
      case SupportedMethods.sendNote:
      // TODO: Handle this case.
      case SupportedMethods.getJournal:
      // TODO: Handle this case.
      case SupportedMethods.getJournalSample:
      // TODO: Handle this case.
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
      // TODO: Handle this case.
      case SupportedMethods.init:
      // TODO: Handle this case.
      case SupportedMethods.validateToken:
      // TODO: Handle this case.
      default:
        throw Exception('$method mock method is not implemented');
    }
  }
}
