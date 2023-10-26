import Foundation
@_implementationOnly import RealmSwift

final class Config {
    static let baseServerURL = "https://tapcloud.api.taps.ai/api"
    static let keyboardExtensionBundleID = mainBundleInfo(for: "KEYBOARD_EXTENSION_BUNDLE_ID")

    struct Storage {
        public private(set) static var storageName = mainBundleInfo(for: "QUANTACTIONS_APP_GROUP") ?? ""
        public static let deviceID = "deviceID"
        public static let basicInfo = "basicInfo"
        public static let deviceRegistrationPublicKey = "deviceRegistrationPublicKey"
        public static let lastSyncDate = "lastSyncDate"
        public static let isDataCollectionDisabled = "isDataCollectionDisabled"

        public static func prepareForTesting() {
            Storage.storageName = "test.storage"
        }
    }

    public struct Links {
        public static let privacyPolicy = URL(string: "https://quantactions.com/privacy-policy")!
    }

    public struct Auth {
        public private (set) static var apiKey = mainBundleInfo(for: "QUANTACTIONS_API_KEY") ?? ""

        public static func prepareForTesting() {
            Auth.apiKey = "44270d6e-f590-4c87-a559-d13843cfa8a369d2e305-e801-4b76-9195-84577bef6d2c"
        }
    }

    struct FleksyKeyboardLicense {
        public static let licenseKey = "ae704835-5e12-4afc-a98c-a8b3db64e9ab"
        public static let licenseSecret = "8897ba52cd0389816822a92bb720ae3b"
    }

    struct RealmConfig {
        public static let configuration = Realm.Configuration(
            fileURL: fileURL,
            schemaVersion: 1_0
        )

        private static let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: Storage.storageName)!
            .appendingPathComponent("default.realm")
    }

    static func info(for key: String) -> String? {
        let bundle = Bundle(identifier: "com.quantactions.QuantActionsSDK")

        guard
            let dictionary = bundle?.infoDictionary,
            let value = dictionary[key] as? String
        else {
            return nil
        }

        return value
    }

    static func mainBundleInfo(for key: String) -> String? {
        var bundle = Bundle.main
        if bundle.bundleURL.pathExtension == "appex" {
            let url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
            if let otherBundle = Bundle(url: url) {
                bundle = otherBundle
            }
        }

        guard
            let dictionary = bundle.infoDictionary,
            let value = dictionary[key] as? String
        else {
            return nil
        }

        return value
    }
}

extension Config {
    static func prepareForTesting() {
        Config.Storage.prepareForTesting()
        Config.Auth.prepareForTesting()
    }
}
