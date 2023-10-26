@_implementationOnly import RealmSwift
import Foundation

final class TapDataSessionDBO: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var startedAt: Date
    @Persisted var endedAt: Date
    @Persisted var tapEvents: List<TapEventDBO>
    @Persisted var rawFleksyKeyboardData: String
}
