@_implementationOnly import RealmSwift
import Foundation

final class SleepSummaryMetricDBO: MetricOrTrendDBO {
    @Persisted var sleepDate: Date
    @Persisted var wakeDate: Date
    @Persisted var interruptionsStart: List<Date>
    @Persisted var interruptionsStop: List<Date>
    @Persisted var interruptionsNumberOfTaps: List<Int>
    @Persisted var timeZone: String
}

struct SleepSummaryElementMapper: Mapper {
    func map(from object: SleepSummaryMetricDBO) -> SleepSummaryElement {
        SleepSummaryElement(
            sleepDate: object.sleepDate,
            wakeDate: object.wakeDate,
            interruptionsStart: Array(object.interruptionsStart),
            interruptionsStop: Array(object.interruptionsStop),
            interruptionsNumberOfTaps: Array(object.interruptionsNumberOfTaps),
            timeZone: object.timeZone
        )
    }
}
