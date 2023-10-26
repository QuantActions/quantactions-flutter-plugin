import Foundation

struct ErrorHandler {
    let error: Error

    func handle() -> QAError {
        let wrapper = LocalizedErrorWrapper(error: error)

        return QAError(
            description: wrapper.errorDescription ?? "Unknown error",
            reason: wrapper.failureReason
        )
    }
}

fileprivate struct LocalizedErrorWrapper: LocalizedError {
    private let underlyingLocalizedError: LocalizedError?
    private let fallbackDescription: String?

    var errorDescription: String? {
        underlyingLocalizedError?.errorDescription ?? fallbackDescription
    }

    var failureReason: String? {
        underlyingLocalizedError?.failureReason
    }

    init(error: Error?) {
        if let localizedError = error as? LocalizedError {
            underlyingLocalizedError = localizedError
            fallbackDescription = error.debugDescription
        } else {
            underlyingLocalizedError = nil
            fallbackDescription = error?.localizedDescription ?? ""
        }
    }
}
