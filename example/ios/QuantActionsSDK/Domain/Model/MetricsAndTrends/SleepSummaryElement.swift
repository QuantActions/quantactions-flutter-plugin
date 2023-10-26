/// This data struct hold detailed information about a sleep session (or sleep episode).
public struct SleepSummaryElement: DataPointElement {
    /// Date of the bed time.
    public let sleepDate: Date

    /// Date of the wake up time.
    public let wakeDate: Date

    /// List of Dates of the beginning on interruptions of the sleep episode.
    public let interruptionsStart: [Date]

    /// List of Dates of the end on interruptions of the sleep episode.
    public let interruptionsStop: [Date]

    /// Number of taps in each sleep interruption.
    public let interruptionsNumberOfTaps: [Int]

    /// Time zone in which the sleep episode occured.
    public let timeZone: String
}
