@_implementationOnly import RealmSwift
import Foundation

final class SleepScoreMetricDBO: MetricOrTrendDBO {
    @Persisted var sleepScore: Double
    @Persisted var confidenceIntervalLow: Double
    @Persisted var confidenceIntervalHigh: Double
    @Persisted var confidence: Double
    @Persisted var wakeDate: Date
    @Persisted var timeZone: String
}

struct SleepScoreElementMapper: Mapper {
    func map(from object: SleepScoreMetricDBO) -> SleepScoreElement {
        SleepScoreElement(
            sleepScore: object.sleepScore,
            confidenceIntervalLow: object.confidenceIntervalLow,
            confidenceIntervalHigh: object.confidenceIntervalHigh,
            confidence: object.confidence,
            wakeDate: object.wakeDate,
            timeZone: object.timeZone
        )
    }
}
