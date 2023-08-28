import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String tempApiKey = "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9";
  final _qa = QAFlutterPlugin();
  late Stream<List<JournalEntryWithEvents>> _stream;

  String? errorText;

  @override
  void initState() {
    super.initState();
    try {
      _initDependencies();
    } catch (e) {
      errorText = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: errorText != null
            ? Text(errorText!)
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _stream,
                        builder: (_,
                            AsyncSnapshot<List<JournalEntryWithEvents>>
                                snapshot) {
                          if (snapshot.hasData) {
                            final List<JournalEntryWithEvents> response =
                                snapshot.data as List<JournalEntryWithEvents>;

                            return ListView.builder(
                              itemCount: response.length,
                              itemBuilder: (_, int index) {
                                final JournalEntryWithEvents item =
                                    response[index];
                                return Text(item.toString());
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return Text('init: ${snapshot.error.toString()}');
                          }

                          return Text('init: ${snapshot.connectionState.name}');
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _initDependencies() {
    // _qa.firebaseToken;
    // _qa.deviceId;
    // _qa.basicInfo;
    // _qa.isTablet;
    // _qa.getJournalEntry('journalEntryId');
    _stream = _qa.getJournal();
    // _qa.getQuestionnairesList();
    // _qa.getJournalSample(apiKey: tempApiKey);
    // _qa.init(
    //     apiKey: tempApiKey,
    //     // age: 1991,
    //     // gender: Gender.other,
    //     // selfDeclaredHealthy: true,
    // );
    // _qa.isInit();
    // _qa.recordQuestionnaireResponse(
    //   name: 'name',
    //   code: 'code',
    //   date: DateTime.now(),
    //   fullId: 'fullId',
    //   response: 'response',
    // );
    // _qa.getMetricSample(apiKey: tempApiKey, metric: Metric.actionSpeed);
    // _qa.getSubscriptionIdAsync();
    // _qa.getSubscriptionId();
    // _qa.subscribe(subscriptionIdOrCohortId: 'subscriptionIdOrCohortId');
    // _qa.getCohortList();
    // // _qa.getMetricAsync(Metric.actionSpeed);
    // _qa.createJournalEntry(
    //   date: DateTime.now(),
    //   note: 'note',
    //   events: [],
    //   ratings: [1, 2],
    //   oldId: 'oldId',
    // );
    // _qa.getStatSampleAsync(apiKey: tempApiKey, metric: Trend.actionSpeed);
    // _qa.validateToken(apiKey: tempApiKey);
    // _qa.savePublicKey();
    // _qa.updateBasicInfo(
    //   newYearOfBirth: 1881,
    //   newGender: Gender.male,
    //   newSelfDeclaredHealthy: false,
    // );
    // _qa.initAsync(apiKey: tempApiKey);
    // _qa.canUsage();
    // _qa.sendNote('text');
    // _qa.deleteJournalEntry(id: 'id');
    // _qa.isDeviceRegistered();
    // _qa.subscribeWithGooglePurchaseToken(purchaseToken: 'purchaseToken');
    // _qa.redeemVoucher(voucher: 'voucher');
    // _qa.pauseDataCollection();
    // _qa.resumeDataCollection();
    // _qa.isDataCollectionRunning();
    // _qa.leaveCohort('cohortId');
    // _qa.setVerboseLevel(1);
    // _qa.canDraw();
    // _qa.getJournalEvents();
    // _qa.syncData();
  }
}
