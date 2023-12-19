import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';

import '../../domain/domain.dart';
import '../consts/supported_methods.dart';
import 'factories/basic_info_factory.dart';
import 'factories/cohort_factory.dart';
import 'factories/journal_entry.dart';
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
      SupportedMethods.canUsage || SupportedMethods.init:
        return faker.randomGenerator.boolean();
      case SupportedMethods.resumeDataCollection ||
      SupportedMethods.pauseDataCollection ||
      SupportedMethods.updateBasicInfo:
        return;
      case SupportedMethods.getJournalEntry || SupportedMethods.saveJournalEntry:
        return _getJournalEntry();
      case SupportedMethods.getStatSampleAsync:
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
        return _getJournalEntries(length: 10);
      case SupportedMethods.journalEventKinds:
        return _getJournalEventEntityList();
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

  static Stream<String> _getJournalEntries({required int length}) {
    return Stream<String>.value(
      jsonEncode(
        JournalEntryFactory()
            .generateListFake(length: 10)
            .map((JournalEntry event) => event.toJson())
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

  static Future<String> _getJournalEventEntityList() {
    return Future<String>.value(
      jsonEncode(
        <JournalEventEntity>[
          JournalEventEntity(
            id: '610d0e05-3eff-4a02-af45-cc864b3b894b',
            publicName: 'family',
            iconName: 'HouseUser',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '1cf52057-edf1-4abb-8fcd-2f81a9f6fe14',
            publicName: 'pets',
            iconName: 'Paw',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '2e6a1d72-a725-42c3-8d7a-544718d7bb1a',
            publicName: 'sleep',
            iconName: 'Bed',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '496cf70f-0326-471c-a83d-481546410edb',
            publicName: 'walk',
            iconName: 'Walking',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '5501654c-5504-4239-b914-40d057351a8b',
            publicName: 'cigarettes',
            iconName: 'Smoking',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '59722b05-ea16-4499-90c8-60472093620e',
            publicName: 'work',
            iconName: 'Briefcase',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '625f5bd5-fcbc-4b80-916e-a15dcf3b6a8f',
            publicName: 'exercise',
            iconName: 'Dumbbell',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '7f411a95-f5e9-4b3f-bdc2-94f71a7c021e',
            publicName: 'pain',
            iconName: 'BandAid',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '827f01ac-fb92-491f-85cf-903c93f4bbf2',
            publicName: 'friends',
            iconName: 'UserFriends',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: '88d42a9b-14dc-413e-968c-536482c34bc3',
            publicName: 'diet',
            iconName: 'Utensils',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'a44bd7f0-fc06-4819-ab81-921dc2deaf52',
            publicName: 'travel',
            iconName: 'Plane',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'b646e1e9-203f-460d-bd7c-d60f4fc5b5e0',
            publicName: 'outdoors',
            iconName: 'Tree',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'b79c0b1b-6fb1-4a64-811b-ea47fb09b540',
            publicName: 'alcohol',
            iconName: 'WineGlassAlt',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'cef426b5-38cd-4b17-bdb1-4652607f9238',
            publicName: 'relationship',
            iconName: 'Heart',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'f081b4a5-df1a-4ce3-a5d2-53e31498ec1f',
            publicName: 'mindfulness',
            iconName: 'YinYang',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
          JournalEventEntity(
            id: 'f6827faf-7536-4b2c-8c02-5a2a58dcbf2f',
            publicName: 'other',
            iconName: 'Ghost',
            created: DateTime.now(),
            modified: DateTime.now(),
          ),
        ],
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
