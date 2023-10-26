import SwiftUI
import FleksyKeyboardSDK

open class QAKeyboardViewController: FKKeyboardViewController {
    private let viewModel = KeyboardViewModel()

    public override var appIcon: UIImage? {
        UIImage(systemName: "gearshape")
    }

    public override func createConfiguration() -> KeyboardConfiguration {
        let typing = TypingConfiguration()

        let licenseConfig = LicenseConfiguration(
            licenseKey: Config.FleksyKeyboardLicense.licenseKey,
            licenseSecret: Config.FleksyKeyboardLicense.licenseSecret
        )

        let dataConfig = FLDataConfiguration(
            configFormat: .dataConfigFormat_groupByTap
        )

        let capture = DataCaptureMode.sessionBased(
            output: enumCaptureOutput.captureOutput_string,
            configuration: dataConfig,
            logEvents: false
        )

        let noFullAccessApp = NoFullAccessViewKeyboardApp()
        noFullAccessApp.delegate = self

        let languagesApp = LanguagesKeyboardApp()

        let style = StyleConfiguration()
        style.spacebarStyle = .spacebarStyle_Automatic

        let config = KeyboardConfiguration(
            dataCapture: capture,
            style: style,
            typing: typing,
            specialKeys: nil,
            apps: AppsConfiguration(
                keyboardApps: [noFullAccessApp, languagesApp],
                showAppsInCarousel: false
            ),
            license: licenseConfig
        )

        return config
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.synchronize()

        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Double(UIDevice.current.batteryLevel)
        viewModel.send(batteryLevel: batteryLevel)

        if !hasFullAccess {
            openApp(appId: NoFullAccessViewKeyboardApp.id)
        }
    }

    public override func dataCollection(_ data: String, sessionId: String) {
        viewModel.handleSession(data: data)
    }

    public override func triggerOpenApp() {
        openApp(appId: LanguagesKeyboardApp.id)
    }
}

extension QAKeyboardViewController: NoFullAccessViewKeyboardAppDelegate {
    func noFullAccessViewKeyboardAppDidOpenSettingsTap() {
        openSettings()
    }

    private func openSettings() {
        var responder: UIResponder? = self
        var sharedApplication: UIResponder?
        while responder != nil {
            if let application = responder as? UIApplication {
                sharedApplication = application
                break
            }
            responder = responder?.next
        }

        guard
            let application = sharedApplication,
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        else {
            return
        }

        application.perform("openURL:", with: settingsUrl)
    }
}
