struct SocialTapsDataItemDTO: Decodable {
    let index: String
    let values: Double

    enum CodingKeys: String, CodingKey {
        case index
        case values
    }
}

extension SocialTapsDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> DoubleValueMetricDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = DoubleValueMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.value = values
        dbo.confidenceIntervalLow = nil
        dbo.confidenceIntervalHigh = nil
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
