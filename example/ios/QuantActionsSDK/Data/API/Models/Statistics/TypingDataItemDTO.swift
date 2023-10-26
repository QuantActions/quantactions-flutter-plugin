struct TypingDataItemDTO: Decodable {
    let index: String
    let typingSpeed: Double
    let confidenceIntervalLow: Double
    let confidenceIntervalHigh: Double

    enum CodingKeys: String, CodingKey {
        case index
        case typingSpeed = "typing-speed"
        case confidenceIntervalLow = "ci-l"
        case confidenceIntervalHigh = "ci-h"
    }
}

extension TypingDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> DoubleValueMetricDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = DoubleValueMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.value = typingSpeed
        dbo.confidenceIntervalLow = confidenceIntervalLow
        dbo.confidenceIntervalHigh = confidenceIntervalHigh
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
