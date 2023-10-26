import SwiftUI
import FleksyKeyboardSDK

fileprivate enum LanguagesPath: Hashable {
    case languageDetails(code: String)
}

struct LanguagesView: View {
    let closeAction: () -> Void

    @State private var path = [LanguagesPath]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    NavigationLink(
                        "English (US)",
                        value: LanguagesPath.languageDetails(code: "en-US")
                    )
                    NavigationLink(
                        "Dutch",
                        value: LanguagesPath.languageDetails(code: "nl-NL")
                    )
                    NavigationLink(
                        "German",
                        value: LanguagesPath.languageDetails(code: "de-DE")
                    )
                    NavigationLink(
                        "Italian",
                        value: LanguagesPath.languageDetails(code: "it-IT")
                    )
                    NavigationLink(
                        "French (FR)",
                        value: LanguagesPath.languageDetails(code: "fr-FR")
                    )
                } header: {
                    Text("Select language")
                }
            }
            .navigationDestination(for: LanguagesPath.self) { destination in
                switch destination {
                case .languageDetails(let code):
                    LanguageDetails(
                        code: code,
                        selectAction: {
                            LanguagesHelperWrapper.shared.changeLanguage(
                                KeyboardLanguage(locale: code)
                            )
                            
                            closeAction()
                        }
                    )
                    .navigationTitle(code)
                }
            }
            .navigationTitle("Languages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: closeAction)
                }
            }
        }
    }
}
