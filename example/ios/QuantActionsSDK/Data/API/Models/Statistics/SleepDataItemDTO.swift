struct SleepDataItemDTO: Decodable {
    let index: String
    let sleepScore: Double
    let confidenceIntervalLow: Double
    let confidenceIntervalHigh: Double
    let confidence: Double
    let wakeUTC: Int
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case index
        case sleepScore = "sleep-score"
        case confidenceIntervalLow = "ci-l"
        case confidenceIntervalHigh = "ci-h"
        case confidence = "conf"
        case wakeUTC = "wake-utc"
        case timeZone = "time-zone"
    }
}

extension SleepDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> SleepScoreMetricDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: index) ?? .now

        let dbo = SleepScoreMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.sleepScore = sleepScore
        dbo.confidenceIntervalLow = confidenceIntervalLow
        dbo.confidenceIntervalHigh = confidenceIntervalHigh
        dbo.confidence = confidence
        dbo.wakeDate = Date(millisecondsSince1970: wakeUTC)
        dbo.timeZone = timeZone
        dbo.updatedAt = .now
        dbo.code = code

        return dbo
    }
}
