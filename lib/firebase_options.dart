// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDDzGg0GtSZ6uW_iDd9sLNjUZHy3t6UUE0',
    appId: '1:757360984332:web:70215b54e403e39968c929',
    messagingSenderId: '757360984332',
    projectId: 'codeclimx-20240307',
    authDomain: 'codeclimx-20240307.firebaseapp.com',
    storageBucket: 'codeclimx-20240307.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMaWhuiHK1Kn8SJAX8lrlEdUSnaUNiEr8',
    appId: '1:757360984332:android:8fee9c2f163af9f168c929',
    messagingSenderId: '757360984332',
    projectId: 'codeclimx-20240307',
    storageBucket: 'codeclimx-20240307.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4wNE_Yib0WARZbehENtnCanYR0dQbTcw',
    appId: '1:757360984332:ios:35cde0b1f23e926868c929',
    messagingSenderId: '757360984332',
    projectId: 'codeclimx-20240307',
    storageBucket: 'codeclimx-20240307.appspot.com',
    iosBundleId: 'com.example.codeclimx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4wNE_Yib0WARZbehENtnCanYR0dQbTcw',
    appId: '1:757360984332:ios:74548227abd970d068c929',
    messagingSenderId: '757360984332',
    projectId: 'codeclimx-20240307',
    storageBucket: 'codeclimx-20240307.appspot.com',
    iosBundleId: 'com.example.codeclimx.RunnerTests',
  );
}