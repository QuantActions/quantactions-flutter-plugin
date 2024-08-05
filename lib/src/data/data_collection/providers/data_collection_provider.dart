/// Interface for data collection providers.
abstract class DataCollectionProvider {
  /// Check if data collection is running.
  Future<bool> isDataCollectionRunning();

  /// Pause data collection.
  Future<void> pauseDataCollection();

  /// Resume data collection.
  Future<void> resumeDataCollection();
}
