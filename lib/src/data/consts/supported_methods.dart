/// This class contains all the supported methods for the method channel and event channel.
class SupportedMethods {
  // method channel

  /// basic info
  static const String getBasicInfo = 'getBasicInfo';

  /// device ID
  static const String getDeviceID = 'getDeviceID';

  /// latest taps
  static const String getLastTaps = 'getLastTaps';

  /// is keyboard added (ios only)
  static const String getIsKeyboardAdded = 'getIsKeyboardAdded';

  /// is data collection running
  static const String isDataCollectionRunning = 'isDataCollectionRunning';

  /// re-start data collection
  static const String resumeDataCollection = 'resumeDataCollection';

  /// pause data collection
  static const String pauseDataCollection = 'pauseDataCollection';

  /// was device registered
  static const String isDeviceRegistered = 'isDeviceRegistered';

  /// get journal entry
  static const String getJournalEntry = 'getJournalEntry';

  /// get metric sample
  static const String getStatSampleAsync = 'getStatSampleAsync';

  /// activity permission status
  static const String canActivity = 'canActivity';

  /// draw over permission status
  static const String canDraw = 'canDraw';

  /// usage permission status
  static const String canUsage = 'canUsage';

  /// request draw over permission
  static const String requestOverlayPermission = 'requestOverlayPermission';

  /// request usage permission
  static const String requestUsagePermission = 'requestUsagePermission';

  /// update basic info
  static const String updateBasicInfo = 'updateBasicInfo';

  /// leave cohort
  static const String leaveCohort = 'leaveCohort';

  /// save entry
  static const String saveJournalEntry = 'saveJournalEntry';

  /// delete entry
  static const String deleteJournalEntry = 'deleteJournalEntry';

  /// send simple note
  static const String sendNote = 'sendNote';

  /// sync data
  static const String syncData = 'syncData';

  /// save questionnaire response
  static const String recordQuestionnaireResponse =
      'recordQuestionnaireResponse';

  /// init SDK
  static const String init = 'init';

  /// get connected devices
  static const String getConnectedDevices = 'getConnectedDevices';

  /// open battery optimization settings (android only)
  static const String openBatteryOptimisationSettings =
      'openBatteryOptimisationSettings';

  /// get password
  static const String getPassword = 'getPassword';

  /// get identity
  static const String getIdentityId = 'getIdentityId';

  /// get cohort list
  static const String subscriptions = 'subscriptions';

  /// keyboard settings (ios only)
  static const String keyboardSettings = 'keyboardSettings';

  /// update keyboard settings (ios only)
  static const String updateKeyboardSettings = 'updateKeyboardSettings';

  /// get FCM token for notifications
  static const String updateFCMToken = 'updateFCMToken';

  /// core motion permission status (ios only)
  static const String coreMotionAuthorizationStatus =
      'coreMotionAuthorizationStatus';

  /// health kit permission status (ios only)
  static const String isHealthKitAuthorizationStatusDetermined =
      'isHealthKitAuthorizationStatusDetermined';

  /// request core motion permission (ios only)
  static const String requestCoreMotionAuthorization =
      'requestCoreMotionAuthorization';

  /// request health kit permission (ios only)
  static const String requestHealthKitAuthorization =
      'requestHealthKitAuthorization';

  //event channel

  /// cohort list
  static const String getCohortList = 'getCohortList';

  /// subscribe to cohort
  static const String subscribe = 'subscribe';

  /// journal entry
  static const String journalEntries = 'journalEntries';

  /// journal sample
  static const String journalEntriesSample = 'journalEntriesSample';

  /// event kinds
  static const String journalEventKinds = 'journalEventKinds';

  /// metric
  static const String getMetric = 'getMetric';

  /// metric sample
  static const String getMetricSample = 'getMetricSample';

  /// questionnaire list for cohort
  static const String getQuestionnairesList = 'getQuestionnairesList';
}
