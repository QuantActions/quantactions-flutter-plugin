public struct SleepScoreElement: DataPointElement {
    public let sleepScore: Double

    /// Lowest bound of the confidence for the current metrics.
    public let confidenceIntervalLow: Double

    /// Highest bound of the confidence for the current metrics.
    public let confidenceIntervalHigh: Double

    /// General confidence of the assumptions for the current metrics.
    public let confidence: Double

    /// Date of the wake up time.
    public let wakeDate: Date
    
    /// Time zone in which the sleep episode occured.
    public let timeZone: String
}
