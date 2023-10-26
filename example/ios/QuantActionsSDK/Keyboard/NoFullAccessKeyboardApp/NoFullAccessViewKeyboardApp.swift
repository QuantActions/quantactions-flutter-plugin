import UIKit
import SwiftUI
import FleksyAppsCore

protocol NoFullAccessViewKeyboardAppDelegate: AnyObject {
    func noFullAccessViewKeyboardAppDidOpenSettingsTap()
}

///Based on official example: https://github.com/FleksySDK/VirtualKeyboardSDK/blob/main/examples/open-view/ios/KeyboardOpenView/keyboard/KeyboardOpenViewCustom.swift
final class NoFullAccessViewKeyboardApp: KeyboardApp {
    static let id = "noFullAccessViewApp"

    let appId = NoFullAccessViewKeyboardApp.id
    private var configuration: AppConfiguration?
    private var listener: AppListener?

    weak var delegate: NoFullAccessViewKeyboardAppDelegate? = nil

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
            createNoFullAccessView()
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

    private func createNoFullAccessView() {
        let noFullAccessView = NoFullAccessView(
            settingsAction: { [weak self] in
                self?.delegate?.noFullAccessViewKeyboardAppDidOpenSettingsTap()
            }
        )
        let viewController = UIHostingController(rootView: noFullAccessView)

        view = viewController.view
    }
}
