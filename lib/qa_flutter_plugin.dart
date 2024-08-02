import 'src/core/core.dart';
import 'src/data/data.dart';
import 'src/domain/domain.dart';

export 'package:quantactions_flutter_plugin/src/domain/models/models.dart';

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

  ///[BasicInfo] for the current user
  Future<BasicInfo> get basicInfo => _userRepository.getBasicInfo();

  ///ID of the device
  Future<String> get deviceId => _deviceRepository.getDeviceID();

  ///User password
  Future<String?> get password => _userRepository.getPassword();

  ///The method is only relevant for Android
  ///User identity id
  Future<String> get identityId => _userRepository.getIdentityId();

  ///KeyboardSettings
  Future<KeyboardSettings> get keyboardSettings => _deviceRepository.keyboardSettings();

  ///The method is only relevant for iOS
  ///A boolean indicating if the keyboard is added in the system Keyboards settings.
  ///It determines whether the keyboard is added or not based on KEYBOARD_EXTENSION_BUNDLE_ID field
  ///from Info.plist file of the keyboard companion app.
  ///Returns nil if the KEYBOARD_EXTENSION_BUNDLE_ID is not added to the Info.plist file properly.
  Future<bool?> get isKeyboardAdded => _deviceRepository.getIsKeyboardAdded();


  ///Retrieves last taps in requested backward time
  Future<int> getLastTaps({required int backwardDays}) async {
    return _deviceRepository.getLastTaps(backwardDays: backwardDays);
  }

  ///Retrieves the list of paired devices
  Future<List<dynamic>> getConnectedDevices() async {
    return _deviceRepository.getConnectedDevices();
  }

  /// Updates current keyboard settings. See [KeyboardSettings] fields for more details.
  Future<void> updateKeyboardSettings({
    required KeyboardSettings keyboardSettings,
  }) async {
    await _deviceRepository.updateKeyboardSettings(keyboardSettings: keyboardSettings);
  }

  /// Updates current keyboard settings. See [KeyboardSettings] fields for more details.
  Future<void> updateFCMToken({
    required String token,
  }) async {
    await _deviceRepository.updateFCMToken(token: token);
  }

  ///Retrieves the list of studies the device is currently registered for.
  Stream<List<Cohort>> getCohortList() {
    return _cohortRepository.getCohortList();
  }

  ///Use this to withdraw the device from a particular cohort.
  Future<void> leaveCohort(String subscriptionId, String cohortId) async {
    await _cohortRepository.leaveCohort(subscriptionId, cohortId);
  }

  ///The method is only relevant for Android
  ///This function check that the data collection is currently running.
  Future<bool> isDataCollectionRunning() async {
    return _dataCollectionRepository.isDataCollectionRunning();
  }

  ///Restart the data collection after it has been purposely paused.
  Future<void> resumeDataCollection() async {
    await _dataCollectionRepository.resumeDataCollection();
  }

  ///Pause the data collection.
  Future<void> pauseDataCollection() async {
    await _dataCollectionRepository.pauseDataCollection();
  }

  ///Use this function to subscribe the device to your(one of your) cohort(s).
  Future<SubscriptionWithQuestionnaires> subscribe({
    required String subscriptionIdOrCohortId,
  }) async {
    return _deviceRepository.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );
  }

  ///Returns an object of type [Subscription] that contains
  ///the subscription ID of the cohort to which the device is currently
  ///subscribed to, if multiple devices are subscribed using
  ///the same subscriptionId it returns all the device IDs.
  Future<List<Subscription>> getSubscriptions() async {
    return _deviceRepository.getSubscriptions();
  }

  Future<bool> isDeviceRegistered() async {
    return _deviceRepository.isDeviceRegistered();
  }

  Future<void> openBatteryOptimisationSettings() async {
    await _deviceRepository.openBatteryOptimisationSettings();
  }

  ///Use this function to retrieve a particular journal entry.
  ///You need to provide the id of the entry you want to retrieve,
  ///checkout [getJournalEntries] and JournalEntryWithEvents to see
  ///how to retrieve the id of the entry.
  Future<JournalEntry?> getJournalEntry(String journalEntryId) async {
    return _journalRepository.getJournalEntry(journalEntryId);
  }

  ///Use this utility function to create or edit a journal entry.
  ///In case you want to edit a note you will need to pass the ID of the entity to edit.
  ///The function returns an asynchronous flow with the response of the action.
  ///The response is mostly to trigger UI/UX events,
  ///in case of failure the SDK will take care internally of retrying.
  Future<JournalEntry> saveJournalEntry({
    String? id,
    required DateTime date,
    required String note,
    required List<JournalEvent> events,
  }) async {
    return _journalRepository.saveJournalEntry(
      id: id,
      date: date,
      note: note,
      events: events,
    );
  }

  ///Use this function to delete a journal entry.
  ///You need to provide the id of the entry you want to delete,
  ///checkout [getJournalEntries] and JournalEntryWithEvents
  ///to see how to retrieve the id of the entry to delete.
  Future<void> deleteJournalEntry({required String id}) async {
    await _journalRepository.deleteJournalEntry(id: id);
  }

  ///Saves simple text note.
  Future<void> sendNote(String text) async {
    await _journalRepository.sendNote(text);
  }

  ///This functions returns the full journal of the device,
  ///meaning all entries with the corresponding events.
  ///Checkout JournalEntryWithEvents for a complete description of
  ///how the journal entries are organized.
  Stream<List<JournalEntry>> getJournalEntries() {
    return _journalRepository.getJournalEntries();
  }

  ///This functions returns a fictitious journal and can be used for
  ///test/display purposes, Checkout JournalEntryWithEvents for a complete
  ///description of how the journal entries are organized.
  Future<List<JournalEntry>> getJournalEntriesSample({
    required String apiKey,
  }) async {
    return _journalRepository.getJournalEntriesSample(apiKey: apiKey);
  }

  ///Retrieves the Journal events, meaning the events that one can log together
  ///with a journal entry. The events come from a fixed set which may be
  ///updated in the future, this function return the latest update to the [JournalEventEntity].
  Future<List<JournalEventEntity>> getJournalEventKinds() async {
    return _journalRepository.getJournalEventKinds();
  }

  ///Get a QA metric relative to the device in use.
  ///Check the the list of available metrics from [Metric] or [Trend].
  ///The function returns an object of type [TimeSeries] which contains timestamps
  ///and values of the requested metric. The call is asynchronous ans returns a flow.
  Stream<TimeSeries<dynamic>> getMetric({
    required MetricType metric,
    required MetricInterval interval,
  }) {
    return _metricRepository.getMetric(
      metric: metric,
      interval: interval,
    );
  }

  ///Get a QA metric relative to a fictitious test device.
  ///Check the the list of available metrics from [Metric] or [Trend].
  ///The function returns an object of type [TimeSeries] which contains timestamps
  ///and values of the requested metric. The call is asynchronous ans returns a flow.
  ///You can use this function to test your data workflow and visualization.
  Stream<TimeSeries<dynamic>> getMetricSample({
    required String apiKey,
    required MetricType metric,
    required MetricInterval interval,
  }) {
    return _metricRepository.getMetricSample(
      apiKey: apiKey,
      metric: metric,
      interval: interval,
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
  }) async {
    return _metricRepository.getStatSampleAsync(
      apiKey: apiKey,
      metric: metric,
    );
  }

  ///The method is only relevant for Android
  ///Returns whether or not the ```activity recognition``` permission has been granted
  Future<bool> canActivity() async {
    return _permissionRepository.canActivity();
  }

  ///The method is only relevant for Android
  ///Returns whether or not the ```draw over other apps``` permission has been granted
  Future<bool> canDraw() async {
    return _permissionRepository.canDraw();
  }

  ///The method is only relevant for Android
  ///Returns whether or not the ```usage``` permission has been granted
  Future<bool> canUsage() async {
    return _permissionRepository.canUsage();
  }

  ///The method is only relevant for Android
  ///Opens device settings to grant the ```draw``` permission
  Future<bool> openDrawSettings() async {
    return _permissionRepository.openDrawSettings();
  }

  ///The method is only relevant for Android
  ///Opens device settings to grant the ```usage``` permission
  Future<bool> openUsageSettings() async {
    return _permissionRepository.openUsageSettings();
  }

  ///Get a list of all the questionnaires available to complete
  ///(across all the studies to which a device is subscribed to).
  Stream<List<Questionnaire>> getQuestionnairesList() {
    return _questionnaireRepository.getQuestionnairesList();
  }

  ///Saves a questionnaire response.
  Future<void> recordQuestionnaireResponse({
    String? name,
    String? code,
    DateTime? date,
    String? fullId,
    String? response,
  }) async {
    await _questionnaireRepository.recordQuestionnaireResponse(
      name: name,
      code: code,
      date: date,
      fullId: fullId,
      response: response,
    );
  }

  ///The first time you use the QA SDK in the code you should initialize it,
  ///this allows the SDK to create a unique identifier and initiate server
  ///transactions and workflows. Most of the functionality will not work
  ///if you have never initialized the singleton before.
  Future<bool> init({
    required String apiKey,
    int? yearOfBirth,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  }) async {
    return _userRepository.init(
      apiKey: apiKey,
      age: yearOfBirth,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
      identityId: identityId,
      password: password,
    );
  }

  ///Use this function to update the basic info of a user.
  ///You can call the function with one or parameters,
  ///the missing ones will be considered unaltered.
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  }) async {
    print('in plugin updateBasicInfo');
    return _userRepository.updateBasicInfo(
      newYearOfBirth: newYearOfBirth,
      newGender: newGender,
      newSelfDeclaredHealthy: newSelfDeclaredHealthy,
    );
  }

  ///Requests permission to read CoreMotion (Motion Activity) data requiered by the SDK.
  Future<bool> requestCoreMotionAuthorization() async {
    return _deviceRepository.requestCoreMotionAuthorization();
  }

  ///Requests permission to read HealthKit data requiered by the SDK.
  Future<bool> requestHealthKitAuthorization() async {
    return _deviceRepository.requestHealthKitAuthorization();
  }

  ///Indicates whether a user was already asked for HealthKit permissions required by the SDK.
  ///Returns true if user was asked for permission by displaying system popup.
  Future<bool> isHealthKitAuthorizationStatusDetermined() async {
    return _deviceRepository.isHealthKitAuthorizationStatusDetermined();
  }

  ///CoreMotion [AuthorizationStatus]
  Future<AuthorizationStatus> coreMotionAuthorizationStatus() async {
    return _deviceRepository.coreMotionAuthorizationStatus();
  }
}
