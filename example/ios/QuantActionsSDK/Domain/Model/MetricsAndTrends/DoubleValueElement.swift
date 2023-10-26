/// Data struct representing double value item of Metric.
public struct DoubleValueElement: DataPointElement {
    public let value: Double

    /// Lowest bound of the confidence for the current metrics
    public let confidenceIntervalLow: Double?

    /// Highest bound of the confidence for the current metrics
    public let confidenceIntervalHigh: Double?
}
