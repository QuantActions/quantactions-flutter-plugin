struct SocialDataItemDTO: Decodable {
    let index: String
    let engagementScore: Double

    enum CodingKeys: String, CodingKey {
        case index
        case engagementScore = "engagement-score"
    }
}

extension SocialDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> some MetricOrTrendDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = DoubleValueMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.value = engagementScore
        dbo.confidenceIntervalLow = nil
        dbo.confidenceIntervalHigh = nil
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
