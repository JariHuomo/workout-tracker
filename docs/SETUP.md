**Setup Guide**

- Date: 2025-10-31

**Prerequisites**
- Flutter SDK 3.24+ installed and on PATH
- Android Studio/Xcode toolchains as needed

**Install Dependencies**
- `flutter pub get`
- `dart run build_runner build --delete-conflicting-outputs`

**Run the App**
- `flutter run`
- Choose a device (Android emulator, iOS simulator, or physical device)

**Run Tests**
- `flutter test`

**Troubleshooting SDK**
- Verify toolchain: `flutter doctor -v`
- If the SDK cache is corrupt:
  - `git -C <flutter-sdk> clean -xfd`
  - `git -C <flutter-sdk> pull`
  - Re-run `flutter doctor`, then `flutter pub get`

**Notification Permissions**
- iOS/macOS: app will request alert/sound on first use of rest timer
- Android: notification channel `rest_timer` is created at startup

**Assets**
- Templates JSON: `assets/data/templates_data.json`
- Ensure `pubspec.yaml` lists the asset under `flutter/assets`

