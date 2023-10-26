import Foundation

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badServerResponse(let status, _):
            return String(localized: "Network error: \(status)")
        case .noResponse:
            return String(localized: "No response")
        case .invalidRequest:
            return String(localized: "Invalid request")
        }
    }
}
