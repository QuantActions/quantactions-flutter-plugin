import Foundation

/// Struct representing errors that may occur within the SDK.
///
/// `QAError` implements ``LocalizedError``  interface.
public struct QAError {
    public let description: String
    public let reason: String?

    init(description: String, reason: String? = nil) {
        self.description = description
        self.reason = reason
    }
}

extension QAError: LocalizedError {
    public var errorDescription: String? {
        description
    }

    public var failureReason: String? {
        reason
    }
}
