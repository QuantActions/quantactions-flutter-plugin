struct ScreenTimeAggregateDataItemDTO: Decodable {
    let index: String
    let screenTime: Int
    let socialScreenTime: Int

    enum CodingKeys: String, CodingKey {
        case index
        case screenTime = "screen-time"
        case socialScreenTime = "social-screen-time"
    }
}

extension ScreenTimeAggregateDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> ScreenTimeAggregateMetricDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = ScreenTimeAggregateMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.screenTime = screenTime
        dbo.socialScreenTime = socialScreenTime
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
