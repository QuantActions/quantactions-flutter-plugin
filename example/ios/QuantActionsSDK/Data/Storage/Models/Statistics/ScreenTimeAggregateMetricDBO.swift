@_implementationOnly import RealmSwift
import Foundation

final class ScreenTimeAggregateMetricDBO: MetricOrTrendDBO {
    @Persisted var screenTime: Int
    @Persisted var socialScreenTime: Int
}

struct ScreenTimeAggregateElementMapper: Mapper {
    func map(from object: ScreenTimeAggregateMetricDBO) -> ScreenTimeAggregateElement {
        ScreenTimeAggregateElement(
            screenTime: Double(object.screenTime),
            socialScreenTime: Double(object.socialScreenTime)
        )
    }
}
