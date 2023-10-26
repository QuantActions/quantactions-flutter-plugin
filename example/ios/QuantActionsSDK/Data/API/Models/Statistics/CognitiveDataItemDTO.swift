struct CognitiveDataItemDTO: Decodable {
    let index: String
    let speedScore: Double
    let confidenceIntervalLow: Double
    let confidenceIntervalHigh: Double

    enum CodingKeys: String, CodingKey {
        case index
        case speedScore = "speed-score"
        case confidenceIntervalLow = "ci-l"
        case confidenceIntervalHigh = "ci-h"
    }
}

extension CognitiveDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> some MetricOrTrendDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = DoubleValueMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.value = speedScore
        dbo.confidenceIntervalLow = confidenceIntervalLow
        dbo.confidenceIntervalHigh = confidenceIntervalHigh
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
