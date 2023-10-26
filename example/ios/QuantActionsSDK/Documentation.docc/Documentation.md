# ``QuantActionsSDK``

## Overview
The QuantActions SDK for iOS allows developers to add all the QuantActions functions to an iOS app including:
* Automatic data collection
* Access processed metrics and insights from the Tap Intelligence Engine (TIE)
* Enabling device communication
* Subscribe to different cohorts

## Installation
QuantActions SDK can be installed with the Swift Package Manager:
```
https://github.com/QuantActions/QA-Swift-SDK
```
The SDK can be added the main app, the keyboard extension and other targets if needed.

## Setup

### API Key
To start using the SDK you will need an API key provided by QuantActions. If you have not yet received your API key please [contact us](mailto:development@quantactions.com).

Add API key to the Info.plist file of your app. If file is not visible in Project Navigator, select your app's target > Info and add new key/value pair.
```
<key>QUANTACTIONS_API_KEY</key>
<string>Your API KEY</string>
```

### Custom Keyboard Extension
The QuantActions SDK does most of the keyboard related work under the hood, but it's still necessary to add the keyboard extension to your app in Xcode.

#### Step 1
1.  Select your Project in the Project Navigator,
2.  Navigate to File > New > Target,
3.  Select the Custom Keyboard Extension from the Application Extension group and click next,
4.  Specify a Product Name and click finish.

#### Step 2
1.  Select keyboard extension target > General Pane > Frameworks and Libraries -> Click "+" button and select QASwiftSDK.
2.  Locate your Custom Keyboard Extension in the Project Navigatior and modify KeyboardViewController class by replacing its content with:
```swift
import QuantActionsSDK

final class KeyboardViewController: QAKeyboardViewController {}
```

#### Step 3
The SDK doesn’t support building with bitcode so it must be disabled to avoid compilation failures.
1.  Select your Custom Keyboard Extension’s General Pane > Build Settings,
2.  Under the Build Options find the option Enable Bitcode and set it to No.

#### Step 4
1.  Navigate to Custom Keyboard Extension’s General Pane > Info > NSExtension,
2.  Under NSExtensionAttributes, find RequestsOpenAccess key of type Boolean and set its value to 1.

### Keyboard Extension Bundle ID
Each keyboard extension may have a different bundle identifier. In order to make QuantActions SDK able to determine keyboard's state, it's necessary to pass your keyboard's bundle id to the SDK via `KEYBOARD_EXTENSION_BUNDLE_ID` field set in Info.plist file of your app.
```
<key>KEYBOARD_EXTENSION_BUNDLE_ID</key>
<string>Your keyboard extension bundle ID</string>
```

### App Group
The QuantActions Keyboard extension might collect data and send server requests under the hood even when the app is killed. In order to share storage between the SDK, your app and keyboard extension, it's necessary to configure App Group within your app's Capabilities. See [Apple's doc](https://developer.apple.com/documentation/xcode/configuring-app-groups) for more information.

Configure your app and keybaord extension to use the same App Group.

After adding the same App Group to an app and the keyboard extension, add the name of the App Group to the Info.plist file of your app using `QUANTACTIONS_APP_GROUP` key:
```
<key>QUANTACTIONS_APP_GROUP</key>
<string>App Group ID</string>
```

## Usage
The main access point for SDK features is a shared instance of ``QA`` struct.

### SDK initialization
Before using any features, the QA SDK needs to be initialized. To do so you will need an API key provided by QuantActions. If you have not yet received your API key please [contact us](mailto:development@quantactions.com).

Add API key to your Info.plist as mentioned in the [`Setup`](#Setup) section.

Initialize the SDK using ``QA/setup(basicInfo:)`` function, for example:
```swift
import QuantActionsSDK
// ...
private func initializeSDK() async {
    do {
        let _ = try await QA.shared.setup()
    } catch {
        // ...
    }
}
```

### Sign-up to a cohort
To track a device it is necessary to subscribe the device to a cohort. Each device can be subscribed in two ways. For a cohort with a known number of devices to track, QuantActions provides a set of codes (subscription / participation IDs) of the form `138e...28eb` that have to be distributed. The way the code is entered into the app is the choice of the developer. In our TapCounter R&D app we use both a copy&paste method and a QR code scanning method, once the code as been acquired the device can then be registered using the SDK.
```swift
let subscription = try await QA.shared.subscribe(participationID: subscriptionID)
```

For cohorts where the number of participants is unknown the SDK can be used to register the device by simply using the cohortId provided by QA (this way needs special access so make sure you are authorized by QuantActions to use this functionality).
```swift
let subscription = try await QA.shared.subscribe(participationID: cohortID)
```

Note that multiple devices can be subscribed using the same `subscriptionID`, this is the case when a user has multiple devices or changes device (e.g. old phone is broken). The data from multiple devices sharing the same `subscriptionID` will be merged to generate insights and metric, thus the same `subscriptionID` should not be used for different users. When subscribing the device using a general `cohortID`, get device gets automatically assigned a `subscriptionID`, to retrieve this id and use it to register other devices use the following code.
```swift
let subscription = try await QA.shared.subscription()
let subscriptionID = subscription?.id
```

### Metrics and Trends retrieval
While the data collection and synchronization is automated within the SDK. Retrieval of metrics and insights has to be done manually within the app in order to access only the subset of metrics and trends that the application needs.

#### Metrics
There are the following methods for retrieving different kind of Metrics:
* Action Speed Metric: ``QA/actionSpeedMetric(participationID:interval:)``
* Typing Speed Metric: ``QA/typingSpeedMetric(participationID:interval:)``
* Congitive Fitness Metric: ``QA/cognitiveFitnessMetric(participationID:interval:)``
* Social Engagement Metric: ``QA/socialEngagementMetric(participationID:interval:)``
* Social Taps Metric: ``QA/socialTapsMetric(participationID:interval:)``
* Screen Time Aggregate Metric: ``QA/screenTimeAggregateMetric(participationID:interval:)``
* Sleep Score Metric ``QA/sleepScoreMetric(participationID:interval:)``
* Sleep Summary Metric ``QA/sleepSummaryMetric(participationID:interval:)``

#### Trends
There is the following method for retrieving Trends based on the given kind of trend:
* ``QA/trend(participationID:interval:trendKind:)``

#### Metric and Trend example

**Date Interval**

Use `year`, `month` and `day` components while creating `DateInterval`. 
The example below shows the date range for which data from the entire year 2023 will be returned.

```swift
private var dateInterval: DateInterval {
    let startComponents = DateComponents(year: 2023, month: 1, day: 1)
    let endComponents = DateComponents(year: 2023, month: 12, day: 31)

    let start = Calendar.current.date(from: startComponents) ?? .now
    let end = Calendar.current.date(from: endComponents) ?? .now

    return DateInterval(start: start, end: end)
}
```

**Metric**

To retrieve metric, use one of available methods listed above. Also, if needed, there are two helper functions for getting average values calculated by grouping results by months (`monthlyAverages`) or weeks (`weeklyAverages`).
For example:

```swift
let metric = try await repository.typingSpeedMetric(
    participationID: participationID,
    interval: dateInterval
)

let monthlyAverages = metric.monthlyAverages
let weeklyAverages = metric.weeklyAverages
```

**Trend**

To retrieve trend, use ``QA/trend(participationID:interval:trendKind:)`` Also, if needed, there are two helper functions for getting average values calculated by grouping results by months (`monthlyAverages`) or weeks (`weeklyAverages`).
For example:

```swift
let trend = try await QA.shared.trend(
    participationID: participationID,
    interval: dateInterval,
    trendKind: .sleepScore
)

let weeklyAverages = trend.weeklyAverages
let monthlyAverages = trend.monthlyAverages
```

### Pausing data collection
Although we do not recommend it, the data collection can be paused/resumed via methods offered by the QA shared instance: ``QA/pauseDataCollection()``, ``QA/resumeDataCollection()``.
You can also check the data collection running state by using ``QA/isDataCollectionRunning`` property.

### Journaling
The SDK allows also to use a journaling function to log a series of entries. Each entry is composed of:
* A date
* A small text describing the entry
* A list of events (from a predefined pool)
* A rating (1 to 5) for each event in the entry

The predefined ``JournalEventKind``s can be retrieved with ``QA/journalEventKinds()``. With that adding an entry is done by using ``QA/saveJournalEntry(journalEntry:)``.

Entries can also be deleted: ``QA/deleteJournalEntry(byID:)``.

The full journal (all entries) can be retrieved with ``QA/journalEntries()``.

### Issue tracking and contact
Feel free to use the issue tracking of this repo to report any problem with the SDK, in case of more immediate assistance need feel free to contact us at <development@quantactions.com>.
