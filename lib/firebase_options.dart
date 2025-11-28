// File generated manually from GoogleService-Info.plist
// For Android support, add google-services.json and regenerate this file

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK8uVJCQP0Uzwq3oUOFBhzdug6FcQdGcQ',
    appId: '1:566756386372:ios:3fab84d8b4f3a87b7dbe11',
    messagingSenderId: '566756386372',
    projectId: 'pasargad-fe51b',
    storageBucket: 'pasargad-fe51b.firebasestorage.app',
    iosBundleId: 'com.pasargadrugs',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY', // TODO: Replace with actual Android API key
    appId: 'YOUR_ANDROID_APP_ID', // TODO: Replace with actual Android App ID
    messagingSenderId: '566756386372',
    projectId: 'pasargad-fe51b',
    storageBucket: 'pasargad-fe51b.firebasestorage.app',
    androidClientId: 'YOUR_ANDROID_CLIENT_ID', // TODO: Add if needed
  );
}

