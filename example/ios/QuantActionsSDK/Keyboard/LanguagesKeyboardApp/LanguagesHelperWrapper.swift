import FleksyKeyboardSDK

/// Async/await wrapper for Fleksy keyboard [LanguagesHelper](https://docs.fleksy.com/sdk-ios/api-reference-ios/languageshelper/).
struct LanguagesHelperWrapper {
    static let shared = LanguagesHelperWrapper()

    func downloadLanguage(_ language: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            LanguagesHelper.downloadLanguage(language) { result in
                continuation.resume(with: result)
            }
        }
    }

    func addLanguage(_ language: KeyboardLanguage) {
        LanguagesHelper.addLanguage(language)
    }

    func deleteLanguage(_ language: String) -> String? {
        LanguagesHelper.deleteLanguage(language)
    }

    func changeLanguage(_ language: KeyboardLanguage) {
        LanguagesHelper.changeLanguage(language)
    }

    /// All languages available in Fleksy keyboard. It always makes request to remote server.
    func availableLanguages() async -> [String: LanguageResourceFiles] {
        await withCheckedContinuation { continuation in
            LanguagesHelper.availableLanguages { result in
                if let result {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(returning: [:])
                }
            }
        }
    }

    /// Languages stored locally in Fleksy keyboard.
    func availableResources() async -> [String: LanguageResource] {
        await withCheckedContinuation { continuation in
            LanguagesHelper.availableResources { result in
                if let result {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(returning: [:])
                }
            }
        }
    }
}
