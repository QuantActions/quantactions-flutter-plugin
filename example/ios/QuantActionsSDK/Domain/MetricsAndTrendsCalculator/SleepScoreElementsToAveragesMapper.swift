struct SleepScoreElementsToAveragesMapper: Mapper {
    func map(from object: [SleepScoreElement]) -> SleepScoreElement {
        SleepScoreElement(
            sleepScore: object.compactMap { $0.sleepScore }.average ?? 0,
            confidenceIntervalLow: object.compactMap { $0.confidenceIntervalLow }.average ?? 0,
            confidenceIntervalHigh: object.compactMap { $0.confidenceIntervalHigh }.average ?? 0,
            confidence: object.compactMap { $0.confidence }.average ?? 0,
            wakeDate: object.compactMap { $0.wakeDate }.average ?? .now,
            timeZone: object.first?.timeZone ?? ""
        )
    }
}
