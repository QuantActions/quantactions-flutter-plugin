import Foundation

/// This is the main element used to access all the functionality of the QA SDK.
/// As a singleton it can be called easily from anywhere in the code and gives access to all the possible interactions with the QA backend, as well as some functions to retrieve user metrics.
///
/// Since most of the calls are asynchronous, they use [Swift Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/).
public struct QA {
    public static let shared = QA()

    internal let journalingRepository = JournalingRepository()
    internal let metricsAndTrendsRepository = MetricsAndTrendsRepository()

    private let tapDevicesRepository = TapDevicesRepository()
    private let deviceParticipationsRepository = DeviceParticipationsRepository()
    private let deviceIDStorage = DeviceIDStorage()
    private let tapDataSessionStorage = TapDataSessionStorage()
    private let userDefaults = UserDefaults(suiteName: Config.Storage.storageName)!

    /// Indicates whether the current device has been registered and the SDK has been initialized on this device.
    public var isDeviceRegistered: Bool {
        userDefaults.string(forKey: Config.Storage.deviceRegistrationPublicKey) != nil
    }

    /// ID of the current device. ID is generated locally during the first SDK setup.
    public var deviceID: String {
        deviceIDStorage.deviceID
    }

    /// A boolean indicating if the data collection is running or not.
    public var isDataCollectionRunning: Bool {
        !userDefaults.bool(forKey: Config.Storage.isDataCollectionDisabled)
    }

    /// A boolean indicating if the keyboard is added in the system Keyboards settings.
    /// It determines whether the keyboard is added or not based on `KEYBOARD_EXTENSION_BUNDLE_ID` field from Info.plist file of the keyboard companion app.
    /// Returns `nil` if the `KEYBOARD_EXTENSION_BUNDLE_ID` is not added to the Info.plist file properly.
    ///
    /// Each keyboard extension may have a different bundle identifier. In order to make QuantActionsSDK able to determine keyboard's state, it's necessary to pass your keyboard's bundle id to the SDK via `KEYBOARD_EXTENSION_BUNDLE_ID` field set in Info.plist file of your app.
    public var isKeyboardAdded: Bool? {
        guard
            let keyboards = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String],
            let keyboardExtensionBundleID = Config.keyboardExtensionBundleID
        else {
            return nil
        }

        return keyboards.contains(keyboardExtensionBundleID)
    }

    /// The first time you use the QA SDK in the code you should initialize it, this allows the SDK to create a unique
    /// identifier and initiate server transactions and workflows. Most of the functionality will not work if you have never
    /// initialized the singleton before.
    ///
    /// Remember about adding API Key and App Group to your plist file before calling `setup`.
    ///
    /// The QuantActions Keyboard extension might collect data and send server requests under the hood even when the app is killed.
    /// In order to share storage between the SDK and the keyboard, it's necessary to configure App Group within your app's Capabilities and add its name to the plist file appropriately.
    /// See [Apple's doc](https://developer.apple.com/documentation/xcode/configuring-app-groups) for more information.
    ///
    /// - Parameters:
    ///   - basicInfo: ``BasicInfo`` data struct with basic demographic information of the user associated with the device.
    /// - Returns: boolean, whether or not it was the first time that the SDK was initialized.
    public func setup(
        basicInfo: BasicInfo = BasicInfo()
    ) async throws -> Bool {
        let isFirstTimeSetup = !isDeviceRegistered

        do {
            try validateSetup()

            if isFirstTimeSetup {
                try await tapDevicesRepository.registerDevice(
                    deviceInfo: DeviceInfoFactory.deviceInfo,
                    basicInfo: basicInfo
                )
            } else {
                let localBasicInfo: BasicInfo? = userDefaults.decodable(forKey: Config.Storage.basicInfo)

                let _ = try await tapDevicesRepository.updateDevice(
                    deviceInfo: DeviceInfoFactory.deviceInfo,
                    basicInfo: localBasicInfo ?? basicInfo
                )
            }
        } catch {
            throw ErrorHandler(error: error).handle()
        }

        do {
            try await journalingRepository.syncJournalEventKindsFromRemote()
        } catch {
            Log.qa.error("Couldn't sync JournalEvent items: \(error.localizedDescription)")
        }

        do {
            try await journalingRepository.syncFromRemoteToLocal()
        } catch {
            Log.qa.error("Couldn't sync Journaling: \(error.localizedDescription)")
        }

        return isFirstTimeSetup
    }

    /// Use this function to subscribe the device to your (one of your) cohort(s).
    ///
    /// - Parameter participationID: can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`)
    public func subscribe(participationID: String) async throws -> SubscriptionWithQuestionnaires {
        do {
            return try await tapDevicesRepository.signUpForStudy(
                participationID: participationID
            )
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Use this to withdraw the device from a particular cohort.
    ///
    /// - Parameter participationID: can be cohort ID (`aef3...de19`) or subscription ID (`138e...28eb`)
    public func leaveCohort(participationID: String) async throws {
        do {
            return try await deviceParticipationsRepository.withdrawFromStudy(
                deviceUUID: deviceIDStorage.deviceID,
                participationID: participationID
            )
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Use this function to get current subscription.
    ///
    /// - Returns: An object of type ``Subscription`` that contains the subscription ID of the cohort to which the device is currently subscribed to,
    /// if multiple devices are subscribed using the same subscription ID it returns all the device IDs.
    /// If the device is not subscribed, nil is returned.
    public func subscription() async throws -> Subscription? {
        let basicInfo: BasicInfo? = userDefaults.decodable(forKey: Config.Storage.basicInfo)

        do {
            let subscriptionWithQuestionnaires = try await tapDevicesRepository.updateDevice(
                deviceInfo: DeviceInfoFactory.deviceInfo,
                basicInfo: basicInfo ?? BasicInfo()
            )

            guard let firstItem = subscriptionWithQuestionnaires.first else {
                return nil
            }

            return SubscriptionWithQuestionnairesToSubscriptionMapper().map(from: firstItem)
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Use this function to update the basic info of a user.
    ///
    /// - Parameter basicInfo: ``BasicInfo`` data struct with basic demographic information of the user associated with the device.
    public func update(basicInfo: BasicInfo) async throws {
        do {
            let _ = try await tapDevicesRepository.updateDevice(
                deviceInfo: DeviceInfoFactory.deviceInfo,
                basicInfo: basicInfo
            )
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Utility function to sync all the local data with the server.
    public func syncData() async throws {
        do {
            try await tapDevicesRepository.synchronize(
                deviceID: deviceIDStorage.deviceID
            )

            try await journalingRepository.syncFromRemoteToLocal()
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Retrieves taps for the given interval.
    /// - Parameter interval: Date interval for which taps will be returned.
    /// - Returns: An array of dates representing timestamps for taps.
    public func tapEvents(in interval: DateInterval) -> [Date] {
        tapDataSessionStorage.tapEvents(
            in: interval
        )
    }

    /// Saves simple text note.
    ///
    /// - Parameter text: simple text
    public func sendNote(text: String) async throws {
        do {
            let _ = try await tapDevicesRepository.submitNote(note: text)
        } catch {
            throw ErrorHandler(error: error).handle()
        }
    }

    /// Pauses the data collection.
    public func pauseDataCollection() {
        userDefaults.set(true, forKey: Config.Storage.isDataCollectionDisabled)
    }

    /// Restarts the data collection after it has been purposely paused.
    public func resumeDataCollection() {
        userDefaults.set(false, forKey: Config.Storage.isDataCollectionDisabled)
    }

    private func validateSetup() throws {
        guard
            !Config.Auth.apiKey.isEmpty,
            !Config.Storage.storageName.isEmpty
        else {
            throw QAError(
                description: "Missing QUANTACTIONS_API_KEY and/or QUANTACTIONS_APP_GROUP.\nMake sure they are added to the .plist file of your app."
            )
        }
    }
}
