/// Data struct representing single item while retrieveing Metrics or Trends.
public struct DataPoint<T: DataPointElement> {
    public let date: Date
    public let element: T?
}

public protocol DataPointElement {

}
