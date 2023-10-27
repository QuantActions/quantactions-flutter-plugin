class SupportedMethods {
  //method channel
  static const String getBasicInfo = 'getBasicInfo';
  static const String getDeviceID = 'getDeviceID';
  static const String getIsKeyboardAdded = 'getIsKeyboardAdded';
  static const String isDataCollectionRunning = 'isDataCollectionRunning';
  static const String resumeDataCollection = 'resumeDataCollection';
  static const String pauseDataCollection = 'pauseDataCollection';
  static const String isDeviceRegistered = 'isDeviceRegistered';
  static const String getJournalEntry = 'getJournalEntry';
  static const String getMetricAsync = 'getMetricAsync';
  static const String getStatSampleAsync = 'getStatSampleAsync';
  static const String canDraw = 'canDraw';
  static const String canUsage = 'canUsage';
  static const String updateBasicInfo = 'updateBasicInfo';
  static const String leaveCohort = 'leaveCohort';
  static const String saveJournalEntry = 'saveJournalEntry';
  static const String deleteJournalEntry = 'deleteJournalEntry';
  static const String sendNote = 'sendNote';
  static const String recordQuestionnaireResponse = 'recordQuestionnaireResponse';
  static const String init = 'init';

  //event channel
  static const String getCohortList = 'getCohortList';
  static const String subscribe = 'subscribe';
  static const String subscription = 'subscription';
  static const String getJournal = 'getJournal';
  static const String getJournalSample = 'getJournalSample';
  static const String journalEventKinds = 'journalEventKinds';
  static const String getMetric = 'getMetric';
  static const String getMetricSample = 'getMetricSample';
  static const String getQuestionnairesList = 'getQuestionnairesList';
}
