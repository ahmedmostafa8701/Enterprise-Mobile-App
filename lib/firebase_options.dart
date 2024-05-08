// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-vOfHzmEUbKEE-pwAdKM-KBvp6q8H_4U',
    appId: '1:975893221294:web:271a7597edef0c8ce7c23f',
    messagingSenderId: '975893221294',
    projectId: 'enterprise-mobile-app-983d8',
    authDomain: 'enterprise-mobile-app-983d8.firebaseapp.com',
    databaseURL: 'https://enterprise-mobile-app-983d8-default-rtdb.firebaseio.com',
    storageBucket: 'enterprise-mobile-app-983d8.appspot.com',
    measurementId: 'G-ZTXY2X46P2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoV_h7Wmj2LZVfZ3A7kB5embfXa1jpX1c',
    appId: '1:975893221294:android:2b6e14e826799551e7c23f',
    messagingSenderId: '975893221294',
    projectId: 'enterprise-mobile-app-983d8',
    databaseURL: 'https://enterprise-mobile-app-983d8-default-rtdb.firebaseio.com',
    storageBucket: 'enterprise-mobile-app-983d8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjfwm5zlVJutqA6zF-HFZkk7qul2auph0',
    appId: '1:975893221294:ios:bad6e0b026d6f975e7c23f',
    messagingSenderId: '975893221294',
    projectId: 'enterprise-mobile-app-983d8',
    databaseURL: 'https://enterprise-mobile-app-983d8-default-rtdb.firebaseio.com',
    storageBucket: 'enterprise-mobile-app-983d8.appspot.com',
    iosBundleId: 'com.example.assign1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjfwm5zlVJutqA6zF-HFZkk7qul2auph0',
    appId: '1:975893221294:ios:bad6e0b026d6f975e7c23f',
    messagingSenderId: '975893221294',
    projectId: 'enterprise-mobile-app-983d8',
    databaseURL: 'https://enterprise-mobile-app-983d8-default-rtdb.firebaseio.com',
    storageBucket: 'enterprise-mobile-app-983d8.appspot.com',
    iosBundleId: 'com.example.assign1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-vOfHzmEUbKEE-pwAdKM-KBvp6q8H_4U',
    appId: '1:975893221294:web:e29f56e88086c8f5e7c23f',
    messagingSenderId: '975893221294',
    projectId: 'enterprise-mobile-app-983d8',
    authDomain: 'enterprise-mobile-app-983d8.firebaseapp.com',
    databaseURL: 'https://enterprise-mobile-app-983d8-default-rtdb.firebaseio.com',
    storageBucket: 'enterprise-mobile-app-983d8.appspot.com',
    measurementId: 'G-NLH9YLCSJ1',
  );
}
