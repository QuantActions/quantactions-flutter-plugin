struct TrendElementsToAveragesMapper: Mapper {
    func map(from object: [TrendElement]) -> TrendElement {
        TrendElement(
            difference2Weeks: object.compactMap { $0.difference2Weeks }.average,
            statistic2Weeks: object.compactMap { $0.statistic2Weeks }.average,
            significance2Weeks: object.compactMap { $0.significance2Weeks }.average,
            difference6Weeks: object.compactMap { $0.difference6Weeks }.average,
            statistic6Weeks: object.compactMap { $0.statistic6Weeks }.average,
            significance6Weeks: object.compactMap { $0.significance6Weeks }.average,
            difference1Year: object.compactMap { $0.difference1Year }.average,
            statistic1Year: object.compactMap { $0.statistic1Year }.average,
            significance1Year: object.compactMap { $0.significance1Year }.average
        )
    }
}
