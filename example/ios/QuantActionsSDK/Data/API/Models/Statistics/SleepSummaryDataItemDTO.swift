struct SleepSummaryDataItemDTO: Decodable {
    let date: String
    let sleepUTC: Int
    let wakeUTC: Int
    let interruptionsStart: [Int]
    let interruptionsStop: [Int]
    let interruptionsNumberOfTaps: [Int]
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case date
        case sleepUTC = "sleep-utc"
        case wakeUTC = "wake-utc"
        case interruptionsStart = "int-start"
        case interruptionsStop = "int-stop"
        case interruptionsNumberOfTaps = "int-ntaps"
        case timeZone = "time-zone"
    }
}

extension SleepSummaryDataItemDTO: MappableToMetricOrTrendDBO {
    func map(code: String) -> SleepSummaryMetricDBO {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let date = dateFormatter.date(from: date) ?? .now
        let interruptionsStart = interruptionsStart.map { Date(millisecondsSince1970: $0) }
        let interruptionsStop = interruptionsStop.map { Date(millisecondsSince1970: $0) }

        let dbo = SleepSummaryMetricDBO()
        dbo.timestamp = date.millisecondsSince1970
        dbo.date = date
        dbo.sleepDate = Date(millisecondsSince1970: sleepUTC)
        dbo.wakeDate = Date(millisecondsSince1970: wakeUTC)
        dbo.interruptionsStart.append(objectsIn: interruptionsStart)
        dbo.interruptionsStop.append(objectsIn: interruptionsStop)
        dbo.interruptionsNumberOfTaps.append(objectsIn: interruptionsNumberOfTaps)
        dbo.timeZone = timeZone
        dbo.updatedAt = .now
        dbo.code = code
        
        return dbo
    }
}
