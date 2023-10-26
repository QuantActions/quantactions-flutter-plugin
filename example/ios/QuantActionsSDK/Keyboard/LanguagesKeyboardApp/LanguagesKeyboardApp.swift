import UIKit
import SwiftUI
import FleksyAppsCore

final class LanguagesKeyboardApp: KeyboardApp {
    static let id = "languagesKeyboardApp"

    let appId = LanguagesKeyboardApp.id
    private var configuration: AppConfiguration?
    private var listener: AppListener?

    private var view: UIView?

    func initialize(listener: AppListener, configuration: AppConfiguration) {
        self.listener = listener
        self.configuration = configuration
    }

    func dispose() {
        listener = nil
        configuration = nil
    }

    var defaultViewMode: KeyboardAppViewMode {
        .fullCover()
    }

    ///
    /// From the keyboardViewController you can decide when to call this method,
    /// which will show the view that you send here.
    ///
    func open(viewMode: KeyboardAppViewMode, theme: AppTheme) -> UIView? {
        if view == nil {
            createLanguagesView()
        }
        return view
    }

    /// This is gonna be called automatically by the system when you close the View.
    func close() {
        view = nil
    }

    func onThemeChanged(_ theme: AppTheme) {}

    func appIcon() -> UIImage? {
        nil
    }

    ///
    /// Configure this to hide itself.
    /// Normally, you might add a button in the view to trigger this hide() action. After this action, the system itself will call close() method.
    ///
    @MainActor @objc func hideMyself() {
        listener?.hide()
    }

    @MainActor
    private func createLanguagesView() {
        let languagesView = LanguagesView(
            closeAction: { [weak self] in
                self?.listener?.hide()
            }
        )
        let viewController = UIHostingController(rootView: languagesView)

        view = viewController.view
    }
}
