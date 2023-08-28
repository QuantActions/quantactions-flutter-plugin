import 'package:qa_flutter_plugin/src/core/core.dart';
import 'package:qa_flutter_plugin/src/data/data.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

export 'package:qa_flutter_plugin/src/domain/models/models.dart';

class QAFlutterPlugin {
  late CohortRepository _cohortRepository;
  late DataCollectionRepository _dataCollectionRepository;
  late DeviceRepository _deviceRepository;
  late JournalRepository _journalRepository;
  late MetricRepository _metricRepository;
  late PermissionRepository _permissionRepository;
  late QuestionnaireRepository _questionnaireRepository;
  late UserRepository _userRepository;

  QAFlutterPlugin() {
    dataDI.initDependencies();

    _cohortRepository = appLocator.get<CohortRepository>();
    _dataCollectionRepository = appLocator.get<DataCollectionRepository>();
    _deviceRepository = appLocator.get<DeviceRepository>();
    _journalRepository = appLocator.get<JournalRepository>();
    _metricRepository = appLocator.get<MetricRepository>();
    _permissionRepository = appLocator.get<PermissionRepository>();
    _questionnaireRepository = appLocator.get<QuestionnaireRepository>();
    _userRepository = appLocator.get<UserRepository>();
  }

  ///Retrieves the list of studies the device is currently registered for.
  Stream<List<Cohort>> getCohortList() {
    return _cohortRepository.getCohortList();
  }

  ///Use this to withdraw the device from a particular cohort.
  Stream<QAResponse<String>> leaveCohort(String cohortId) {
    return _cohortRepository.leaveCohort(cohortId);
  }

  ///This function check that the data collection is currently running.
  Future<bool?> isDataCollectionRunning() {
    return _dataCollectionRepository.isDataCollectionRunning();
  }

  ///Restart the data collection after it has been purposely paused.
  void resumeDataCollection() {
    _dataCollectionRepository.resumeDataCollection();
  }

  ///Pause the data collection.
  void pauseDataCollection() {
    _dataCollectionRepository.pauseDataCollection();
  }

  Stream<QAResponse<String>> redeemVoucher({
    required String voucher,
  }) {
    return _deviceRepository.redeemVoucher(voucher: voucher);
  }

  Stream<QAResponse<String>> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  }) {
    return _deviceRepository.subscribeWithGooglePurchaseToken(
      purchaseToken: purchaseToken,
    );
  }

  ///Use this function to subscribe the device to your(one of your) cohort(s).
  Stream<QAResponse<String>> subscribe({
    required String subscriptionIdOrCohortId,
  }) {
    return _deviceRepository.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );
  }

  ///Returns an object of type [SubscriptionIdResponse] that contains
  ///the subscription ID of the cohort to which the device is currently
  ///subscribed to, if multiple devices are subscribed using
  ///the same subscriptionId it returns all the device IDs.
  Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionId() {
    return _deviceRepository.getSubscriptionId();
  }

  Future<bool?> isDeviceRegistered() {
    return _deviceRepository.isDeviceRegistered();
  }

  ///Some manufacturers kill apps that are running for too long, on those devices
  ///it is better to ask the user to prevent the OS from killing the app
  ///running this SDK. Call this function to retrieve the Intent that redirects
  ///the user to the correct setting for disabling battery optimization
  ///of the current manufacturer. The functions returns a list,
  ///choose the first intent, in an empty list is returned,
  ///the current manufacturer does not have specific battery optimization options,
  ///thus the request is not needed and the SDk should run safely.
  Future<dynamic> retrieveBatteryOptimizationIntentForCurrentManufacturer() {
    return _deviceRepository
        .retrieveBatteryOptimizationIntentForCurrentManufacturer();
  }

  ///Utility function to sync all the local data with the server.
  ///Due to the complexity of the work, it spawns a Worker and return its UUID.
  ///The status of the worker can be observed to check its status of SUCCESS/FAILURE.
  Future<dynamic> syncData() {
    return _deviceRepository.syncData();
  }

  Future<QAResponse<SubscriptionIdResponse>> getSubscriptionIdAsync() {
    return _deviceRepository.getSubscriptionIdAsync();
  }

  ///Use this function to retrieve a particular journal entry.
  ///You need to provide the id of the entry you want to retrieve,
  ///checkout [getJournal] and JournalEntryWithEvents to see
  ///how to retrieve the id of the entry.
  Future<JournalEntryWithEvents?> getJournalEntry(String journalEntryId) {
    return _journalRepository.getJournalEntry(journalEntryId);
  }

  ///Use this utility function to create or edit a journal entry.
  ///In case you want to edit a note you will need to pass the ID of the entity to edit.
  ///The function returns an asynchronous flow with the response of the action.
  ///The response is mostly to trigger UI/UX events,
  ///in case of failure the SDK will take care internally of retrying.
  Stream<QAResponse<String>> createJournalEntry({
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
    required List<int> ratings,
    required String oldId,
  }) {
    return _journalRepository.createJournalEntry(
      date: date,
      note: note,
      events: events,
      ratings: ratings,
      oldId: oldId,
    );
  }

  ///Use this function to delete a journal entry.
  ///You need to provide the id of the entry you want to delete,
  ///checkout [getJournal] and JournalEntryWithEvents
  ///to see how to retrieve the id of the entry to delete.
  Stream<QAResponse<String>> deleteJournalEntry({
    required String id,
  }) {
    return _journalRepository.deleteJournalEntry(id: id);
  }

  ///Saves simple text note.
  Stream<QAResponse<String>> sendNote(String text) {
    return _journalRepository.sendNote(text);
  }

  ///This functions returns the full journal of the device,
  ///meaning all entries with the corresponding events.
  ///Checkout JournalEntryWithEvents for a complete description of
  ///how the journal entries are organized.
  Stream<List<JournalEntryWithEvents>> getJournal() {
    return _journalRepository.getJournal();
  }

  ///This functions returns a fictitious journal and can be used for
  ///test/display purposes, Checkout JournalEntryWithEvents for a complete
  ///description of how the journal entries are organized.
  Stream<List<JournalEntryWithEvents>> getJournalSample({
    required String apiKey,
  }) {
    return _journalRepository.getJournalSample(apiKey: apiKey);
  }

  ///Retrieves the Journal events, meaning the events that one can log together
  ///with a journal entry. The events come from a fixed set which may be
  ///updated in the future, this function return the latest update to the [JournalEvent].
  Stream<List<JournalEvent>> getJournalEvents() {
    return _journalRepository.getJournalEvents();
  }

  ///Asynchronous version of [getMetric].
  ///The functionality is identical except that it implements
  ///it with a coroutine logic instead of a flow logic.
  ///Can be used in cases where coroutines can be executed and
  ///flow are not necessary, e.g. background update tasks.
  Future<TimeSeries<dynamic>?> getMetricAsync(MetricType metric) {
    return _metricRepository.getMetricAsync(metric);
  }

  ///Get a QA metric relative to the device in use.
  ///Check the the list of available metrics from [Metric] or [Trend].
  ///The function returns an object of type [TimeSeries] which contains timestamps
  ///and values of the requested metric. The call is asynchronous ans returns a flow.
  Stream<TimeSeries<dynamic>> getMetric(MetricType metric) {
    return _metricRepository.getMetric(metric);
  }

  ///Get a QA metric relative to a fictitious test device.
  ///Check the the list of available metrics from [Metric] or [Trend].
  ///The function returns an object of type [TimeSeries] which contains timestamps
  ///and values of the requested metric. The call is asynchronous ans returns a flow.
  ///You can use this function to test your data workflow and visualization.
  Stream<TimeSeries<dynamic>> getMetricSample({
    required String apiKey,
    required MetricType metric,
  }) {
    return _metricRepository.getMetricSample(
      apiKey: apiKey,
      metric: metric,
    );
  }

  ///Asynchronous version of [getMetricSample].
  ///The functionality is identical except that it implements it
  ///with a coroutine logic instead of a flow logic. Can be used in cases
  ///where coroutines can be executed and flow are not necessary, e.g.
  ///background update tasks.
  Future<TimeSeries<dynamic>?> getStatSampleAsync({
    required String apiKey,
    required MetricType metric,
  }) {
    return _metricRepository.getStatSampleAsync(
      apiKey: apiKey,
      metric: metric,
    );
  }

  ///Returns whether or not the ```draw over other apps``` permission has been granted
  Future<bool?> canDraw() {
    return _permissionRepository.canDraw();
  }

  ///Returns whether or not the ```usage``` permission has been granted
  Future<bool?> canUsage() {
    return _permissionRepository.canUsage();
  }

  ///This function checks if the overlay permission has been granted,
  ///if not opens the corresponding settings activity to prompt the user to grant this permission.
  Future<int?> requestOverlayPermission() {
    return _permissionRepository.requestOverlayPermission();
  }

  ///This function checks if the usage permission has been granted,
  ///if not open the corresponding settings activity to prompt the user to grant this permission.
  Future<int?> requestUsagePermission() {
    return _permissionRepository.requestUsagePermission();
  }

  ///Get a list of all the questionnaires available to complete
  ///(across all the studies to which a device is subscribed to).
  Stream<List<Questionnaire>> getQuestionnairesList() {
    return _questionnaireRepository.getQuestionnairesList();
  }

  ///Saves a questionnaire response.
  Stream<QAResponse<String>> recordQuestionnaireResponse({
    String? name,
    String? code,
    DateTime? date,
    String? fullId,
    String? response,
  }) {
    return _questionnaireRepository.recordQuestionnaireResponse(
      name: name,
      code: code,
      date: date,
      fullId: fullId,
      response: response,
    );
  }

  ///Checks whether or not the SDK is initialized.
  Future<bool?> isInit() {
    return _userRepository.isInit();
  }

  ///The first time you use the QA SDK in the code you should initialize it, this allows the SDK
  ///to create a unique identifier and initiate server transactions and workflows.
  ///Most of the functionality will not work if you have never initialized the singleton before.
  Future<bool?> initAsync({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _userRepository.initAsync(
      apiKey: apiKey,
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

  ///The first time you use the QA SDK in the code you should initialize it,
  ///this allows the SDK to create a unique identifier and initiate server
  ///transactions and workflows. Most of the functionality will not work
  ///if you have never initialized the singleton before.
  Stream<QAResponse<String>> init({
    required String apiKey,
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _userRepository.init(
      apiKey: apiKey,
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

  ///Use this function to update the basic info of a user.
  ///You can call the function with one or parameters,
  ///the missing ones will be considered unaltered.
  void updateBasicInfo({
    required int newYearOfBirth,
    required Gender newGender,
    required bool newSelfDeclaredHealthy,
  }) {
    return _userRepository.updateBasicInfo(
      newYearOfBirth: newYearOfBirth,
      newGender: newGender,
      newSelfDeclaredHealthy: newSelfDeclaredHealthy,
    );
  }

  void savePublicKey() {
    _userRepository.savePublicKey();
  }

  void setVerboseLevel(int verbose) {
    _userRepository.setVerboseLevel(verbose);
  }

  ///Use this function to double check that your API key is correct and valid,
  ///this is just for testing purposes.
  Stream<QAResponse<String>> validateToken({
    required String apiKey,
  }) {
    return _userRepository.validateToken(apiKey: apiKey);
  }
}
