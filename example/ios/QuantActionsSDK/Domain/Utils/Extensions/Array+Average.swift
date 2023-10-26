extension Array where Element: BinaryFloatingPoint {
    var average: Double? {
        if isEmpty {
            return nil
        }
        
        let sum = reduce(0, +)
        return Double(sum) / Double(count)
    }
}

extension Array where Element == Date {
    var average: Date? {
        guard !isEmpty else {
            return nil
        }

        let timestamps = map { $0.timeIntervalSince1970 }
        let meanTimestamp = timestamps.reduce(0, +) / Double(timestamps.count)
        let meanDate = Date(timeIntervalSince1970: meanTimestamp)

        return meanDate
    }
}
