import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';

import '../../domain/domain.dart';
import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';
import 'factories/journal_entry_with_events_factory.dart';
import 'factories/journal_event_factory.dart';
import 'factories/metric_factory.dart';
import 'factories/qa_response_string_factory.dart';
import 'factories/qa_response_subscription_factory.dart';
import 'factories/questionnaire_factory.dart';
import 'factories/subscription_with_questionnaires_factory.dart';

class MockDataProvider {
  static dynamic callMockMethod({
    required String method,
    required MetricType? metricType,
  }) {
    switch (method) {
      //methods for method channel
      case SupportedMethods.getBasicInfo:
        return _getBasicInfo();
      case SupportedMethods.getDeviceID:
        return faker.randomGenerator.fromCharSet('1234567890', 10);
      case SupportedMethods.getFirebaseToken:
        return faker.randomGenerator.fromCharSet('1234567890', 25);
      case SupportedMethods.getIsTablet ||
            SupportedMethods.isDataCollectionRunning ||
            SupportedMethods.isDeviceRegistered ||
            SupportedMethods.canDraw ||
            SupportedMethods.canUsage ||
            SupportedMethods.isInit ||
            SupportedMethods.initAsync:
        return faker.randomGenerator.boolean();
      case SupportedMethods.resumeDataCollection ||
            SupportedMethods.pauseDataCollection ||
            SupportedMethods.updateBasicInfo ||
            SupportedMethods.savePublicKey ||
            SupportedMethods.setVerboseLevel:
        return;
      case SupportedMethods.syncData:
        return faker.lorem.sentence();
      case SupportedMethods.getSubscriptionIdAsync:
        return _getQAResponseSubscriptionIdResponse();
      case SupportedMethods.getJournalEntry:
        return _getJournalEntry();
      case SupportedMethods.getMetricAsync || SupportedMethods.getStatSampleAsync:
        if (metricType == null) return;

        return jsonEncode(_getMetric(metricType));

      //methods for event channel
      case SupportedMethods.getCohortList:
        return _getCohortList();
      case SupportedMethods.leaveCohort ||
            SupportedMethods.createJournalEntry ||
            SupportedMethods.deleteJournalEntry ||
            SupportedMethods.sendNote ||
            SupportedMethods.recordQuestionnaireResponse ||
            SupportedMethods.init ||
            SupportedMethods.validateToken:
        return _getQAResponseString();
      case SupportedMethods.redeemVoucher ||
            SupportedMethods.subscribeWithGooglePurchaseToken ||
            SupportedMethods.subscribe:
        return _getQAResponseSubscriptionWithQuestionnaires();
      case SupportedMethods.getSubscriptionId:
        return Stream<String>.value(_getQAResponseSubscriptionIdResponse());
      case SupportedMethods.getJournal || SupportedMethods.getJournalSample:
        return _getJournalEntryWithEventsList(length: 10);
      case SupportedMethods.getJournalEvents:
        return _getJournalEventList();
      case SupportedMethods.getMetric || SupportedMethods.getMetricSample:
        if (metricType == null) return;

        return Stream<String>.value(
          jsonEncode(_getMetric(metricType)),
        );
      case SupportedMethods.getQuestionnairesList:
        return _getQuestionnairesList();
      default:
        throw QAError(
          description: '$method mock method is not implemented',
        );
    }
  }

  static Stream<String> _getJournalEntryWithEventsList({required int length}) {
    return Stream<String>.value(
      jsonEncode(
        JournalEventFactory()
            .generateListFake(length: 10)
            .map((JournalEvent event) => event.toJson())
            .toList(),
      ),
    );
  }

  static Stream<String> _getQAResponseString() {
    return Stream<String>.value(
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
    return Stream<String>.value(
      jsonEncode(
        SubscriptionWithQuestionnairesFactory().generateFake(),
      ),
    );
  }

  static Stream<String> _getQuestionnairesList() {
    return Stream<String>.value(
      jsonEncode(
        QuestionnaireFactory().generateListFake(length: 10),
      ),
    );
  }

  static Stream<String> _getJournalEventList() {
    return Stream<String>.value(
      jsonEncode(
        JournalEventFactory()
            .generateListFake(length: 10)
            .map((JournalEvent event) => event.toJson())
            .toList(),
      ),
    );
  }

  static Stream<String> _getCohortList() {
    return Stream<String>.value(
      jsonEncode(
        CohortFactory()
            .generateListFake(length: 10)
            .map((Cohort cohort) => cohort.toJson())
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

  static dynamic _getMetric(MetricType metricType) {
    if (metricType is Trend) {
      return MetricFactory<TrendHolder>().generateFake();
    } else {
      switch (metricType) {
        case Metric.sleepSummary:
          return MetricFactory<SleepSummary>().generateFake();
        case Metric.screenTimeAggregate:
          return MetricFactory<ScreenTimeAggregate>().generateFake();
        default:
          return MetricFactory<double>().generateFake();
      }
    }
  }
}
