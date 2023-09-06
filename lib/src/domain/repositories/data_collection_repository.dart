abstract class DataCollectionRepository {
  Future<bool> isDataCollectionRunning();

  Future<void> pauseDataCollection();

  Future<void> resumeDataCollection();
}
