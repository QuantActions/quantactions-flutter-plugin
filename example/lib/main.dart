import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

void main() async {
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
  late Stream<Subscription?> _stream;

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
                      child: FutureBuilder(
                        // future: _qa.updateBasicInfo(
                        //   // apiKey: tempApiKey,
                        //   newYearOfBirth: 2000,
                        //   newGender: Gender.male,
                        //   newSelfDeclaredHealthy: false,
                        // ),
                        future: _qa.isDeviceRegistered(),
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasError) {
                            return Text('error: ${snapshot.error}');
                          }
                          if (snapshot.hasData) {
                            return Text('result: ${snapshot.data}');
                          } else {
                            return Text('status: ${snapshot.connectionState}');
                          }
                        },
                      ),
                      // child: StreamBuilder(
                      //   stream: _stream,
                      //   builder: (_, AsyncSnapshot<Subscription?> snapshot) {
                      //     if (snapshot.hasData) {
                      //       if (snapshot.hasError) {
                      //         return Text('error: ${snapshot.error}');
                      //       }
                      //       if (snapshot.hasData) {
                      //         // return Text('result: ${snapshot.data}');
                      //         final List<JournalEntry> response =
                      //             snapshot.data as List<JournalEntry>;
                      //
                      //         return ListView.builder(
                      //           itemCount: response.length,
                      //           itemBuilder: (_, int index) {
                      //             final JournalEntry item = response[index];
                      //             return Text(item.toString());
                      //           },
                      //         );
                      //       } else {
                      //         return Text('status: ${snapshot.connectionState}');
                      //       }
                      //     }
                      //
                      //     if (snapshot.hasError) {
                      //       return Text('init: ${snapshot.error.toString()}');
                      //     }
                      //
                      //     return Text('init: ${snapshot.connectionState.name}');
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _initDependencies() async {
    // _qa.updateBasicInfo(
    //   // apiKey: tempApiKey,
    //   newYearOfBirth: 2000,
    //   newGender: Gender.male,
    //   newSelfDeclaredHealthy: false,
    // );
    // _qa.firebaseToken;
    // _qa.deviceId;
    // _qa.basicInfo;
    // _qa.isTablet;
    // _qa.getJournalEntry('journalEntryId');
    // _qa.getJournal();
    // _qa.getQuestionnairesList();
    // _stream = _qa.getJournalEntriesSample(apiKey: tempApiKey);
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
    // _stream = _qa.getSubscription();
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
    // _qa.updateBasicInfo();
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
