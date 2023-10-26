import SwiftUI
import FleksyKeyboardSDK

fileprivate enum LanguageState {
    case loading
    case downloaded
    case notDownloaded
    case failure
}

struct LanguageDetails: View {
    let code: String
    let selectAction: () -> Void

    @State private var state: LanguageState = .loading

    var body: some View {
        List {
            Section {
                LanguageStateItem(
                    code: code,
                    state: $state
                )
            } header: {
                Text("State")
            } footer: {
                Text("After downloading language will be activated automatically.")
            }

            Section {
                Button("Activate", action: selectAction)
                    .disabled(state != .downloaded)
            } footer: {
                Text("Sets this language as currently used. The language must be downloaded.")
            }
        }
    }
}

fileprivate struct LanguageStateItem: View {
    let code: String
    @Binding var state: LanguageState

    var body: some View {
        HStack {
            switch state {
            case .loading:
                ProgressView()
            case .downloaded:
                Image(systemName: "checkmark.icloud.fill")
                    .foregroundStyle(.green)

                Text("Downloaded")
            case .notDownloaded:
                Image(systemName: "icloud.and.arrow.down")

                Text("Not downloaded")
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .foregroundStyle(.red)

                Text("Failed to download")
            }

            Spacer()

            Button(
                state == .notDownloaded ? "Download" : "Refresh",
                action: download
            )
            .disabled(state == .loading)
        }
        .task {
            state = .loading

            let availableLanguages = await LanguagesHelperWrapper.shared.availableResources()
            let isDownloaded = availableLanguages.contains(where: { $0.key == code })

            if isDownloaded {
                state = .downloaded
            } else {
                state = .notDownloaded
            }
        }
    }

    private func download() {
        Task {
            state = .loading

            do {
                try await LanguagesHelperWrapper.shared.downloadLanguage(code)

                LanguagesHelperWrapper.shared.addLanguage(
                    KeyboardLanguage(locale: code)
                )

                state = .downloaded
            } catch {
                state = .failure
            }
        }
    }
}
