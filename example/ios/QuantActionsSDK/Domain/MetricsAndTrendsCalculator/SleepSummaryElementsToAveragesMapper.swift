struct SleepSummaryElementsToAveragesMapper: Mapper {
    func map(from object: [SleepSummaryElement]) -> AveragesSleepSummaryElement {
        AveragesSleepSummaryElement(
            sleepDate: object.compactMap { $0.sleepDate }.average ?? .now,
            wakeDate: object.compactMap { $0.wakeDate }.average ?? .now,
            numberOfInterruptions: object
                .compactMap { Double($0.interruptionsStart.count) }
                .average ?? 0
        )
    }
}

public struct AveragesSleepSummaryElement: DataPointElement {
    public let sleepDate: Date
    public let wakeDate: Date
    public let numberOfInterruptions: Double
}
