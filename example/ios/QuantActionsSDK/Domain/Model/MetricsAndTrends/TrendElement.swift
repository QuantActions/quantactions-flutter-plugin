/// Data struct containing all the information about the trend.
public struct TrendElement: DataPointElement {
    /// Metric difference over 2 weeks
    public let difference2Weeks: Double?

    /// Metric difference statistic over 2 weeks
    public let statistic2Weeks: Double?

    /// Metric difference significance over 2 weeks
    public let significance2Weeks: Double?

    /// Metric difference over 6 weeks
    public let difference6Weeks: Double?

    /// Metric difference statistic over 6 weeks
    public let statistic6Weeks: Double?

    /// Metric difference significance over 6 weeks
    public let significance6Weeks: Double?

    /// Metric difference over 1 year
    public let difference1Year: Double?

    /// Metric difference statistic over 1 year
    public let statistic1Year: Double?

    /// Metric difference significance over 1 year
    public let significance1Year: Double?
}
