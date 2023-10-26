import Foundation

extension LocalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .descriptive(let text):
            return text
        case .mapping(let keyPath):
            return "Mapping: \(keyPath)"
        }
    }
}
