# Myanmar NRC Picker UI Kit for Flutter

<?code-excerpt path-base="example/lib"?>

[![pub package](https://img.shields.io/pub/v/mm_nrc_kit.svg)](https://pub.dev/packages/mm_nrc_kit)

![image](testing/mm_nrc_kit_testing.gif)

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
    nrcValue: "8/MaKaNa(N)000000",
    height: 50,
    isExpand: false,
    backgroundColor: Colors.white,
    borderColor: Colors.grey,
    borderWidth: 0.4,
    borderRadius: 10,
    pickerColor: const Color(0xffeeeeee),
    pickerItemColor: Colors.black,
    onCompleted: (value) {
      debugPrint("onCompleted : $value");
    },
    onChanged: (value) {
      debugPrint("onChanged : $value");
    },
  )
```
