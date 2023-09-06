abstract class DataCollectionProvider {
  Future<bool> isDataCollectionRunning();

  Future<void> pauseDataCollection();

  Future<void> resumeDataCollection();
}
