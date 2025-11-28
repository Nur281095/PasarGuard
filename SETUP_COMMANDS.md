# 🚀 Quick Setup Commands - Firebase Crashlytics Symbol Upload

Run these commands to complete the Crashlytics symbol upload setup.

---

## 📱 iOS Setup

### 1. Install/Update Pods

```bash
cd ios
pod deintegrate  # Clean old installation (if any)
pod install      # Install with new Crashlytics upload script
cd ..
```

**Expected Output:**
```
Analyzing dependencies
Downloading dependencies
Installing FirebaseCrashlytics (11.x.x)
Generating Pods project
[✓] Pod installation complete!
```

### 2. Verify Build Phase Added

```bash
# Open workspace in Xcode
open ios/Runner.xcworkspace
```

**Manual Check:**
1. Select **Runner** target (left sidebar)
2. Click **Build Phases** tab (top)
3. Scroll to find: `[firebase_crashlytics] Crashlytics Upload Symbols`
4. Should see shell script starting with `#!/bin/sh`

### 3. Test with Release Build

```bash
flutter build ios --release
```

**Look for in output:**
```
🔥 Firebase Crashlytics: Uploading dSYM files...
✅ Found upload-symbols at: [path]
📤 Uploading dSYM files for Release build...
✅ dSYM upload completed successfully
```

---

## 🤖 Android Setup

### 1. Clean Previous Builds

```bash
cd android
./gradlew clean
cd ..
flutter clean
```

### 2. Get Dependencies

```bash
flutter pub get
cd android
./gradlew --refresh-dependencies
cd ..
```

### 3. Build Release APK

```bash
flutter build apk --release --verbose
```

**Look for in output:**
```
> Task :app:uploadCrashlyticsMapping...Release
🔥 Uploading mapping file to Firebase Crashlytics...
✅ Mapping file uploaded successfully
```

### 4. Verify Mapping File Generated

```bash
ls -la android/app/build/outputs/mapping/release/
```

**Expected:**
```
mapping.txt         ← This file uploaded to Firebase
configuration.txt
seeds.txt
usage.txt
```

---

## 🧪 Testing

### Test iOS Crash Reporting

```bash
# 1. Build release
flutter build ios --release

# 2. Run on device via Xcode
# 3. Add test crash button (see CRASHLYTICS_SYMBOL_UPLOAD_GUIDE.md)
# 4. Tap button → crash → relaunch
# 5. Check Firebase Console in 5-10 minutes
```

### Test Android Crash Reporting

```bash
# 1. Build release APK
flutter build apk --release

# 2. Install on device
adb install build/app/outputs/flutter-apk/app-release.apk

# 3. Add test crash button
# 4. Launch app, tap button → crash → relaunch
# 5. Check Firebase Console in 5-10 minutes
```

---

## 🔍 Verification Commands

### Check Firebase Console

```bash
# Open Firebase Console
open https://console.firebase.google.com/project/pasargadrugs/crashlytics
```

**What to check:**
1. **Dashboard** → Should show crashes (after testing)
2. **Build IDs** → Should list your build versions
3. **Status** → Should show ✅ Symbols uploaded

### Check Local Symbol Files

```bash
# iOS: Check dSYM exists
find build/ios -name "*.dSYM" -type d

# Android: Check mapping exists
cat android/app/build/outputs/mapping/release/mapping.txt | head -20
```

---

## ⚠️ Troubleshooting

### iOS: Upload Script Not Running

```bash
# Reinstall pods completely
cd ios
rm -rf Pods Podfile.lock
rm -rf ~/Library/Caches/CocoaPods
rm -rf ~/Library/Developer/Xcode/DerivedData/*
pod install --repo-update
cd ..
```

### Android: Gradle Plugin Error

```bash
# Update Gradle dependencies
cd android
./gradlew clean build --refresh-dependencies
cd ..

# If still fails, check google-services.json exists:
ls -la android/app/google-services.json
```

### Missing GoogleService-Info.plist (iOS)

```bash
# Check if file exists
ls -la ios/Runner/GoogleService-Info.plist

# If missing, download from:
# https://console.firebase.google.com → Project Settings → Your apps → iOS app → Download
```

### Missing google-services.json (Android)

```bash
# Check if file exists
ls -la android/app/google-services.json

# If missing, download from:
# https://console.firebase.google.com → Project Settings → Your apps → Android app → Download
```

---

## 🎯 Final Verification

Run this complete workflow:

```bash
# Clean everything
flutter clean
cd ios && pod deintegrate && pod install && cd ..
cd android && ./gradlew clean && cd ..

# Build both platforms
flutter build ios --release
flutter build apk --release

# Check for success messages in output
```

**Success indicators:**

iOS:
```
✅ dSYM upload completed successfully
```

Android:
```
> Task :app:uploadCrashlyticsMapping...Release
✅ Mapping file uploaded
```

---

## 📝 Notes

- Symbol uploads happen **automatically** during Release/Profile builds
- No manual upload needed after initial setup
- Each build gets its own symbols uploaded
- Firebase stores symbols for all your builds
- Old symbols never expire (unless manually deleted)

---

**🎉 Setup Complete!**

Your app now automatically uploads symbol files to Firebase Crashlytics on every release build.

