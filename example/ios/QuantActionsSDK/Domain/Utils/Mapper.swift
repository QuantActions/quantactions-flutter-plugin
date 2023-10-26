protocol Mapper {
    associatedtype From
    associatedtype To

    func map(from object: From) throws -> To
}

protocol TwoWayMapper: Mapper {
    func back(from object: To) throws -> From
}
