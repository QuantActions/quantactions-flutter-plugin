/// Interface for data collection repository
abstract class DataCollectionRepository {
  /// Check if data collection is running.
  Future<bool> isDataCollectionRunning();

  /// Pause data collection.
  Future<void> pauseDataCollection();

  /// Resume data collection.
  Future<void> resumeDataCollection();
}
