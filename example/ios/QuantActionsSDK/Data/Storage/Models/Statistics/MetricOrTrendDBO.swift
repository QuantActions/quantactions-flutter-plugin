@_implementationOnly import RealmSwift
import Foundation

class MetricOrTrendDBO: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var timestamp: Int
    @Persisted var date: Date
    @Persisted var code: String
    @Persisted var updatedAt: Date
}
