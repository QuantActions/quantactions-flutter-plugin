abstract class DataCollectionProvider {
  Future<bool?> isDataCollectionRunning();

  void pauseDataCollection();

  void resumeDataCollection();
}
