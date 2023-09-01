import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';

import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';
import 'factories/journal_entry_with_events_factory.dart';
import 'factories/journal_event_factory.dart';
import 'factories/qa_response_string_factory.dart';
import 'factories/qa_response_subscription_factory.dart';
import 'factories/questionnaire_factory.dart';
import 'factories/subscription_with_questionnaires_factory.dart';

class MockDataProvider {
  static dynamic callMockMethod(String method) {
    switch (method) {
      //methods for method channel
      case SupportedMethods.getBasicInfo:
        return _getBasicInfo();
      case SupportedMethods.getDeviceID:
        return faker.randomGenerator.fromCharSet('1234567890', 10);
      case SupportedMethods.getFirebaseToken:
        return faker.randomGenerator.fromCharSet('1234567890', 25);
      case SupportedMethods.getIsTablet:
        return faker.randomGenerator.boolean();
      case SupportedMethods.isDataCollectionRunning:
        return faker.randomGenerator.boolean();
      case SupportedMethods.resumeDataCollection:
        return;
      case SupportedMethods.pauseDataCollection:
        return;
      case SupportedMethods.isDeviceRegistered:
        return faker.randomGenerator.boolean();
      case SupportedMethods.syncData:
        return faker.lorem.sentence();
      case SupportedMethods.getSubscriptionIdAsync:
        return _getQAResponseSubscriptionIdResponse();
      case SupportedMethods.getJournalEntry:
        return _getJournalEntry();
      case SupportedMethods.getMetricAsync:
      // TODO: Handle this case.
      case SupportedMethods.getStatSampleAsync:
      // TODO: Handle this case.
      case SupportedMethods.canDraw:
        return faker.randomGenerator.boolean();
      case SupportedMethods.canUsage:
        return faker.randomGenerator.boolean();
      case SupportedMethods.isInit:
        return faker.randomGenerator.boolean();
      case SupportedMethods.initAsync:
        return faker.randomGenerator.boolean();
      case SupportedMethods.updateBasicInfo:
        return;
      case SupportedMethods.savePublicKey:
        return;
      case SupportedMethods.setVerboseLevel:
        return;

      //methods for event channel
      case SupportedMethods.getCohortList:
        return _getCohortList();
      case SupportedMethods.leaveCohort:
        return _getQAResponseString();
      case SupportedMethods.redeemVoucher:
        return _getQAResponseSubscriptionWithQuestionnaires();
      case SupportedMethods.subscribeWithGooglePurchaseToken:
        return _getQAResponseSubscriptionWithQuestionnaires();
      case SupportedMethods.subscribe:
        return _getQAResponseSubscriptionWithQuestionnaires();
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
        return _getJournalEventList();
      case SupportedMethods.getMetric:
      // TODO: Handle this case.
      case SupportedMethods.getMetricSample:
      // TODO: Handle this case.
      case SupportedMethods.getQuestionnairesList:
        return _getQuestionnairesList();
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
    return jsonEncode(
      QAResponseSubscriptionFactory().generateFake(),
    );
  }

  static Stream<String> _getQAResponseSubscriptionWithQuestionnaires() {
    return Stream.value(
      jsonEncode(
        SubscriptionWithQuestionnairesFactory().generateFake(),
      ),
    );
  }

  static Stream<String> _getQuestionnairesList() {
    return Stream.value(
      jsonEncode(
        QuestionnaireFactory().generateListFake(length: 10),
      ),
    );
  }

  static Stream<String> _getJournalEventList() {
    return Stream.value(
      jsonEncode(
        JournalEventFactory()
            .generateListFake(length: 10)
            .map((cohort) => cohort.toJson())
            .toList(),
      ),
    );
  }

  static Stream<String> _getCohortList() {
    return Stream.value(
      jsonEncode(
        CohortFactory()
            .generateListFake(length: 10)
            .map((cohort) => cohort.toJson())
            .toList(),
      ),
    );
  }

  static String _getJournalEntry() {
    return jsonEncode(
      JournalEntryWithEventsFactory().generateFake(),
    );
  }

  static String _getBasicInfo() {
    return jsonEncode(
      BasicInfoFactory().generateFake(),
    );
  }
}
