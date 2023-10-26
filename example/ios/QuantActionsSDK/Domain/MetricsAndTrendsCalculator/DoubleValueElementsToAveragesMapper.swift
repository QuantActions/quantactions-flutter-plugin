struct DoubleValueElementsToAveragesMapper: Mapper {
    func map(from object: [DoubleValueElement]) -> DoubleValueElement {
        DoubleValueElement(
            value: object.compactMap { $0.value }.average ?? 0,
            confidenceIntervalLow: object.compactMap { $0.confidenceIntervalLow }.average,
            confidenceIntervalHigh: object.compactMap { $0.confidenceIntervalHigh }.average
        )
    }
}
