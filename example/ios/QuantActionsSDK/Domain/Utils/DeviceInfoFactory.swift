import UIKit

struct DeviceInfoFactory {
    static var deviceInfo: DeviceInfo {
        let languageCode = Locale.current.language.languageCode?.identifier
        let bundleVersion = Config.info(for: "CFBundleVersion") ?? "-1"
        let sdkVersion = Int(bundleVersion)

        return .init(
            iOSVersion: UIDevice.current.systemVersion,
            deviceModel: UIDevice.current.modelName,
            language: languageCode ?? "",
            sdkVersion: sdkVersion ?? -1,
            deviceType: UIDevice.current.userInterfaceIdiom == .phone ? "Phone" : "Tablet"
        )
    }
}
