import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';

import '../../domain/domain.dart';
import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';
import 'factories/journal_entry.dart';
import 'factories/journal_event_factory.dart';
import 'factories/metric_factory.dart';
import 'factories/questionnaire_factory.dart';
import 'factories/subscription_factory.dart';
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
      case SupportedMethods.isDataCollectionRunning ||
            SupportedMethods.isDeviceRegistered ||
            SupportedMethods.canDraw ||
            SupportedMethods.canUsage:
        return faker.randomGenerator.boolean();
      case SupportedMethods.resumeDataCollection ||
            SupportedMethods.pauseDataCollection ||
            SupportedMethods.updateBasicInfo:
        return;
      case SupportedMethods.getJournalEntry:
        return _getJournalEntry();
      case SupportedMethods.getMetricAsync || SupportedMethods.getStatSampleAsync:
        if (metricType == null) return;

        return jsonEncode(_getMetric(metricType));

      //methods for event channel
      case SupportedMethods.getCohortList:
        return _getCohortList();
      case SupportedMethods.subscribe:
        return _getSubscriptionWithQuestionnaires();
      case SupportedMethods.subscription:
        return Stream<String>.value(_getSubscriptionResponse());
      case SupportedMethods.journalEntries || SupportedMethods.journalEntriesSample:
        return _getJournalEntryWithEventsList(length: 10);
      case SupportedMethods.journalEventKinds:
        return _getJournalEventList();
      case SupportedMethods.getMetric || SupportedMethods.getMetricSample:
        if (metricType == null) return;

        return Stream<String>.value(
          jsonEncode(_getMetric(metricType)),
        );
      case SupportedMethods.getQuestionnairesList:
        return _getQuestionnairesList();
      default:
        throw Exception('$method mock method is not implemented');
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

  static String _getSubscriptionResponse() {
    return jsonEncode(
      SubscriptionFactory().generateFake(),
    );
  }

  static Stream<String> _getSubscriptionWithQuestionnaires() {
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
      JournalEntryFactory().generateFake(),
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
