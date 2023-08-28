abstract class DataCollectionRepository {
  Future<bool> isDataCollectionRunning();

  void pauseDataCollection();

  void resumeDataCollection();
}
