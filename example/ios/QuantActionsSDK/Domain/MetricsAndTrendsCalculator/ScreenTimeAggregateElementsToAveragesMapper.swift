struct ScreenTimeAggregateElementsToAveragesMapper: Mapper {
    func map(from object: [ScreenTimeAggregateElement]) -> ScreenTimeAggregateElement {
        ScreenTimeAggregateElement(
            screenTime: object.compactMap { $0.screenTime }.average ?? 0,
            socialScreenTime: object.compactMap { $0.socialScreenTime }.average ?? 0
        )
    }
}
