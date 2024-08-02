# QuantActions Flutter Plugin


The QuantActions plugin for Flutter enables a developer to add all the QuantActions functionalities to a Flutter app. This includes:

- Automatic data collection
- Access processed metrics and insights from the Tap Intelligence Engine (TIE)
- Enabling device communication
- Subscribe to different cohorts

The QuantActions plugin for Flutter can be set up with a few easy steps. For a practical example, please see the [example](example) directory.

Important for all this to work you will need an `apiKey` from QuantActions. If you have not yet received your `apiKey` please [contact us](mailto:development@quantactions.com).

## General setup

Add the dependency to your pubspec.yaml file:

```yaml
dependencies:
  quantactions_flutter_plugin: ^0.1.0
```

We recommend the use of [dotenv](https://pub.dev/packages/dotenv) to handle the API key in Flutter.

create a `.env` file in the root of your project and add the following:

```bash
qa_sdk_api_key=apiKey
```

In your main.dart file you can retrieve the api key:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  static final String tempApiKey = dotenv.env['qa_sdk_api_key'] ?? '';
  runApp(MyApp());
}
```


## Android specific setup 
We recommend using Android Gradle Plugin (AGP) 8+ and Kotlin 1.8+.
In your [<root>/android/build.gradle](example/android/build.gradle) add the github maven repo containing the QuantActions Android SDK:

```gradle
allprojects {
    repositories {
        ...
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/QuantActions/quantactions-android-sdk")
        }
    }
}
```

The you can follow the instructions in the [QuantaActions Android SDK](https://quantactions.github.io/QA-Android-SDK-public/) 
on how to setup the android permissions.

Note that you might need to add the direct dependencies to your app/build.gradle file if you decide 
to follow the customization options described in [QuantaActions Android SDK](https://quantactions.github.io/QA-Android-SDK-public/)

```gradle
implementation 'com.quantactions:quantactions-android-sdk:1.1.0-beta06'
```

## iOS specific setup
For iOS specify the api key in your Info.plist file:

```xml
<key>QUANTACTIONS_API_KEY</key>
<string>apiKey</string>
```

Then follow the instruction in the [QuantaActions iOS SDK](https://quantactions.github.io/QA-Swift-SDK/documentation/quantactionssdk)
To add your keyboard extension for the data collection

after this step make sure you adapt the Podspec file to include the SDK dependency into the keyboard extension
for example

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
instantiate like this. This will initialize your SDK with the provided `api_key` and some basic information.

```dart
import 'package:quantactions_flutter_plugin/qa_flutter_plugin.dart';
final _qa = QAFlutterPlugin();
_qa.init(
apiKey: dotenv.env['qa_sdk_api_key'],
age: 1991,
gender: Gender.other,
selfDeclaredHealthy: true
);
```

For returning users (users that have your app on other phones, the devices can be linked (Android only for now))

From the first phone gat the identity and password

```dart
final identity = await _qa.getIdentity();
final password = await _qa.getPassword();
```

Then on the second phone you can link the devices

```dart
final _qa = QAFlutterPlugin();
_qa.init(
apiKey: dotenv.env['qa_sdk_api_key'],
identity: identity,
password: password
);
```






