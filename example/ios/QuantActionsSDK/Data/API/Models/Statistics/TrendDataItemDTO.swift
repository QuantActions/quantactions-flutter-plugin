struct TrendDataItemDTO: Decodable {
    let index: String
    let diff2W: Double?
    let stat2W: Double?
    let sign2W: Double?
    let diff6W: Double?
    let stat6W: Double?
    let sign6W: Double?
    let diff1Y: Double?
    let stat1Y: Double?
    let sign1Y: Double?
}

extension TrendDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> TrendDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = TrendDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.difference2Weeks = diff2W
        dbo.statistic2Weeks = stat2W
        dbo.significance2Weeks = sign2W
        dbo.difference6Weeks = diff6W
        dbo.statistic6Weeks = stat6W
        dbo.significance6Weeks = sign6W
        dbo.difference1Year = diff1Y
        dbo.statistic1Year = stat1Y
        dbo.significance1Year = sign1Y
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
