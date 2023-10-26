@_implementationOnly import RealmSwift

protocol MappableToMetricOrTrendDBO {
    associatedtype RealmElement: MetricOrTrendDBO

    func map(code: String) -> RealmElement
}
