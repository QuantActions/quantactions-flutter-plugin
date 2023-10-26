@_implementationOnly import RealmSwift
import Foundation

final class DoubleValueMetricDBO: MetricOrTrendDBO {
    @Persisted var value: Double
    @Persisted var confidenceIntervalLow: Double?
    @Persisted var confidenceIntervalHigh: Double?
}

struct DoubleValueElementMapper: Mapper {
    func map(from object: DoubleValueMetricDBO) -> DoubleValueElement {
        DoubleValueElement(
            value: object.value,
            confidenceIntervalLow: object.confidenceIntervalLow,
            confidenceIntervalHigh: object.confidenceIntervalHigh
        )
    }
}
