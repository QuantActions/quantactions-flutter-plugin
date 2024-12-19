# QuantActions Flutter Plugin

The QuantActions plugin for Flutter enables a developer to add all the QuantActions functionalities to a Flutter app. This includes:

- Automatic data collection
- Access processed metrics and insights from the Tap Intelligence Engine (TIE)
- Enabling device communication
- Subscribe to different cohorts

The QuantActions plugin for Flutter can be set up with a few easy steps. For a practical example, please see the [example](./example/) directory.

**Important** for the plugin to be functional you will need an `api_key` from QuantActions. If you have not yet received your `api_key` please [contact us](mailto:development@quantactions.com).

## Initial (Flutter) setup

Add the dependency to your pubspec.yaml file:

```yaml
dependencies:
  quantactions_flutter_plugin: ^0.2.1
```

## Initial (Android) setup 
We recommend using Android Gradle Plugin (AGP) 8.5+ and Kotlin 2.0+.
In your [<root>/android/build.gradle](./example/android/build.gradle) add the github maven repo containing the QuantActions Android SDK,
the repo and the package are public but you still need a github account to access them, it is best to use a personal access token for this:

```gradle
allprojects {
    repositories {
        ...
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/QuantActions/quantactions-android-sdk")
            credentials {
                username = '...'
                password = '...'
            }
        }
    }
}
```

**Recommended**: You might want to add some Android specific customization (see below and [QuantaActions Android SDK](https://quantactions.github.io/QA-Android-SDK-public/) to do so you will have to add also the direct dependencies to your app/build.gradle file 

```gradle
implementation 'com.quantactions:quantactions-android-sdk:1.1.1'
```

These steps suffice to correctly integrate the plugin into the app (Android side) but continue reading the [QuantaActions Android SDK](https://quantactions.github.io/QA-Android-SDK-public/) documentations for more information on how to setup the android permissions necessary to start the data collection.

## Initial (iOS) setup

For iOS you can follow the instructions in the [QuantaActions iOS SDK](https://quantactions.github.io/QA-Swift-SDK/documentation/quantactionssdk) documentation in particular you can start from [adding your `api_key`](https://quantactions.github.io/QA-Swift-SDK/documentation/quantactionssdk/#API-Key).
Note that you can skip the installation step of the native SDk as this is already done by the plugin.

You will se in the native iOS documentation that you will need to add a [custom keyboard extension](https://quantactions.github.io/QA-Swift-SDK/documentation/quantactionssdk/#Custom-Keyboard-Extension) that will be responsible to collect the data.

After the iOS setup is done you will need to add to you app Podfile the following lines to make sure that the QuantActions SDK is correctly linked to the keyboard extension.
(Replace `NameOfYourKeyboardExtension` with the name of your keyboard extension)

```ruby
target 'Runner' do
use_frameworks!
use_modular_headers!

    flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

    target 'NameOfYourKeyboardExtension' do
        inherit! :search_paths
    end

end
```

## 2. Adding QA functionality to an app

The whole QA functionality can be accessed everywhere in the code by the singleton `QA` that can be
instantiate like this. 

```dart
import 'package:quantactions_flutter_plugin/quantactions_flutter_plugin.dart';
final qa = QAFlutterPlugin();
```

Before using any functionality, the QA singleton needs to be initialized. To do so you will need an `api_key` provided by QuantActions. If you have not yet received your `api_key` please [contact us](mailto:development@quantactions.com).

We recommend the use of [dotenv](https://pub.dev/packages/dotenv) to handle the API key in Flutter.
Create a `.env` file in the root of your project and add the following:

```bash
api_key=<you_api_key>
```

In your main.dart file you can retrieve the api key:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  static final String tempApiKey = dotenv.env['api_key'] ?? '';
  runApp(MyApp());
}
```

then you can access it in the code and initialize the QuantActions plugin.

```dart
qa.init(
api_key: dotenv.env['api_key'],
age: 1991,
gender: Gender.other,
selfDeclaredHealthy: true
);
```

## 3. Sign-up to a cohort
To track a device it is **necessary** to subscribe the device to a cohort. To do so, simply use the `cohortId` provided by QA.

```dart
qa.subscribe(subscriptionIdOrCohortId: '');
```

When subscribing the device using a `cohortId`, the device gets automatically assigned a `subscriptionId`, to retrieve this id one case use the following code.

```dart
final List<Subscription> subscriptions = await _qa.getSubscriptions();
```

Note that each user can be subscribed to multiple cohorts at the same time

---

## 4. Multiple devices (Android only for now)

It is possible to link multiple devices to the same user by providing `identityId` and `password` during the initialization of the SDK. This way the SDK will be able to link the data from the different devices to the same user.

In the first device, retrieve the `identityId` and `password`:
```dart
final String identityId = await qa.identityId;
final String? password = await qa.password;
```

Then in the second device, initialize the SDK with the `identityId` and `password`:
```dart
qa.init(
api_key: '',
identityId: identityId,
password:password
);
```

IMPORTANT NOTE: Since QuantActions does not have any connection with the user identity, data recovery in case of loss or damage of the device is not possible.
For this reason we suggest storing the QuantActions' `identityId` and `password` together with the user's account info.
In case of loss of damage of the device, the QuantActions SDK can be initialized on the new device with the user's
`identityId` and `password` which will restore the data and guarantee no interruptions of metrics between old and new device.

------------------

## 5. Setup notes:
- Check that you have added the `api_key` correctly where it ness to be added (Info.plist + .env file)
- [Android] Check that you have requested the necessary permissions
- [iOS] Check that you correctly added the keyboard and modified the Podfile

## 6. Checking that everything is running fine
After the integration of the SDK has been done, you can add some checks to make sure everything is running fine.
1. You can check that the SDK has been initialized correctly by using `qa.isDeviceRegistered()` (returns a bool)
2. You can check that the data collection is running fine by using `qa.isDataCollectionRunning()` (returns a bool)
3. You can check that the device has been registered with the QA backend and/or the registration to a cohort was successful
```dart
qa.getSubscriptions();
```

## 7. Pausing data collection

Although we do not recommend it, the data collection can be paused/resumed via the methods offered by QA singleton
```dart
qa.pauseDataCollection();
qa.resumeDataCollection();
```

## 8. Metrics and Trends retrieval
While the data collection and synchronization is automated within the SDK. Retrieval of metrics and insights
has to be done manually within the app in order to access only the subset of metrics and trends that the application needs.

The metrics and trends can be retrieve programmatically in the following way (returns a Stream object):

```dart
qa.getMetric(metric: Metric.sleepScore, interval: MetricInterval.month),
qa.getMetric(metric: Trend.sleepScore, interval: MetricInterval.month),
qa.getMetric(metric: Metric.cognitiveFitness, interval: MetricInterval.month),
qa.getMetric(metric: Trend.cognitiveFitness, interval: MetricInterval.month),
```

Check [Metric](./lib/src/domain/models/metric/metric.dart) and [Trend](./lib/src/domain/models/metric/trend.dart) for the list of
metrics and trends available in the current version of the SDK, also check [MetricInterval](./lib/src/domain/models/metric/metric_interval.dart) for the available intervals.

The function returns an asynchronous Flow containing a
[TimeSeries](./lib/src/domain/models/time_series/time_series.dart) object.
The test app accompanying the SDK has some examples on how to handle the return data.

Since the metrics for a user take from 2 to 7 days to be available (see [ETA](./lib/src/domain/models/metric/metric.dart)).
Developer can have access to sample metrics (that update every day) from a sampled device with 
```dart
qa.getSampleMetric(api_key: api_key, metric: Metric.sleepScore, interval: MetricInterval.month);
```
Note that this method needs to be passed the `api_key` since it can be called without the need for the SDk to be initialized.

## 9. Journaling

The SDK allows also to use a journaling function to log a series of entries. Each entry is composed of:
- A date
- A small text describing the entry
- A list of events (from a predefined pool)
- A rating (1 to 5) for each event in the entry

The predefined [events](./lib/src/domain/models/journal/journal_event_entity.dart) can be retrieved with 
```dart
qa.getJournalEventKinds();
```

With that adding (or editing) an entry is done by using 
```dart
qa.saveJournalEntry(...);
```

Entries can also be deleted
```dart
qa.deleteJournalEntry(...);
```

The full journal (all entries) can be retrieved with 
```dart
qa.getJournalEntries();
```

## 10. Issue tracking and contact
Feel free to contact us at [development@quantactions.com](mailto:development@quantactions.com)








