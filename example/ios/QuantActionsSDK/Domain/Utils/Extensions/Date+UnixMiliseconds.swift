import Foundation

extension Date {
    var millisecondsSince1970: Int {
        Int(timeIntervalSince1970 * 1000)
    }

    init(millisecondsSince1970: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(millisecondsSince1970 / 1000))
    }
}
