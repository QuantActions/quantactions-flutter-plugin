import OSLog

struct Log {
    private static var subsystem = "QuantActionsSDK"

    static let qa = Logger(subsystem: subsystem, category: "QA")
}
