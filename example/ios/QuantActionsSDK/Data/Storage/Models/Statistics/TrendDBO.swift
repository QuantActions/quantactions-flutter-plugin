@_implementationOnly import RealmSwift
import Foundation

final class TrendDBO: MetricOrTrendDBO {
    @Persisted var difference2Weeks: Double?
    @Persisted var statistic2Weeks: Double?
    @Persisted var significance2Weeks: Double?
    @Persisted var difference6Weeks: Double?
    @Persisted var statistic6Weeks: Double?
    @Persisted var significance6Weeks: Double?
    @Persisted var difference1Year: Double?
    @Persisted var statistic1Year: Double?
    @Persisted var significance1Year: Double?
}

struct TrendElementMapper: Mapper {
    func map(from object: TrendDBO) -> TrendElement {
        TrendElement(
            difference2Weeks: object.difference2Weeks,
            statistic2Weeks: object.statistic2Weeks,
            significance2Weeks: object.significance2Weeks,
            difference6Weeks: object.difference6Weeks,
            statistic6Weeks: object.statistic6Weeks,
            significance6Weeks: object.significance6Weeks,
            difference1Year: object.difference1Year,
            statistic1Year: object.statistic1Year,
            significance1Year: object.significance1Year
        )
    }
}
