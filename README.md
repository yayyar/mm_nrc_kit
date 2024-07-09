# Myanmar NRC Picker UI Kit for Flutter

<?code-excerpt path-base="example/lib"?>

[![pub package](https://img.shields.io/pub/v/mm_nrc_kit.svg)](https://pub.dev/packages/mm_nrc_kit)

<h4>
This package is for Myanmar NRC Picker and Number Keyboard.
</h4>

<img src="https://github.com/yayyar/mm_nrc_kit/raw/main/testing/mm_nrc_kit_mm.gif" width="195" height="400" />
<br>
<img src="https://github.com/yayyar/mm_nrc_kit/raw/main/testing/mm_nrc_kit_eng.gif" width="195" height="400" />

## Usage

1. To use this plugin, add `mm_nrc_kit` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

2. Import `mm_nrc_kit`
```dart
import 'package:mm_nrc_kit/mm_nrc_kit.dart';
```

3. Example
```dart
NRCField(
  onCompleted: (value) {
    debugPrint("onCompleted : $value");
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
```
```dart
NRCField(
  language: NrcLanguage.myanmar,
  onCompleted: (value) {
    debugPrint("onCompleted : $value");
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
```
```dart
NRCField(
  language: NrcLanguage.english,
  onCompleted: (value) {
    debugPrint("onCompleted : $value");
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
```
```dart
NRCField(
  language: NrcLanguage.english,
  nrcValue: "8/MAKANA(N)123456",
  leadingTitleFontSize: 14,
  trailingTitleFontSize: 14,
  leadingTitleColor: Colors.black,
  backgroundColor: Colors.white,
  pickerItemColor: Colors.black,
  borderColor: Colors.white,
  borderRadius: 10,
  borderWidth: 0.4,
  contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  onCompleted: (value) {
    debugPrint("onCompleted : $value");
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
```

```dart
NRCField(
  language: NrcLanguage.myanmar,
  nrcValue: "၈/မကန(နိုင်)၁၂၃၄၅၆",
  leadingTitleFontSize: 14,
  trailingTitleFontSize: 14,
  leadingTitleColor: Colors.black,
  backgroundColor: Colors.white,
  pickerItemColor: Colors.black,
  borderColor: Colors.white,
  borderRadius: 10,
  borderWidth: 0.4,
  contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  onCompleted: (value) {
    debugPrint("onCompleted : $value");
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
```

## Conslusion
- Credit : NRC Data and Util to [mm_nrc](https://pub.dev/packages/mm_nrc) package
- UI/UX inspired by SwiftUI flow

``Happy coding`` ``Peace✌️``