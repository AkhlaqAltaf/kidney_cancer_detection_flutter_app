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
    apiKey: 'AIzaSyBIxViD-Gay3M7tgbtttEqXConRP0zxtQc',
    appId: '1:499743383793:web:f2f0f46f11a64e64b64950',
    messagingSenderId: '499743383793',
    projectId: 'kidneycancerdetection',
    authDomain: 'kidneycancerdetection.firebaseapp.com',
    storageBucket: 'kidneycancerdetection.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQyYsa6ay49Znta33b_fjMdvX3RuSXH6I',
    appId: '1:499743383793:android:aec965dcb3b4bac1b64950',
    messagingSenderId: '499743383793',
    projectId: 'kidneycancerdetection',
    storageBucket: 'kidneycancerdetection.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApWPGYZUlydimvGPyLdvFsh-TbLWNQD5c',
    appId: '1:499743383793:ios:98b65f9764bc0140b64950',
    messagingSenderId: '499743383793',
    projectId: 'kidneycancerdetection',
    storageBucket: 'kidneycancerdetection.appspot.com',
    iosBundleId: 'com.example.kidneyCancerDetection',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApWPGYZUlydimvGPyLdvFsh-TbLWNQD5c',
    appId: '1:499743383793:ios:98b65f9764bc0140b64950',
    messagingSenderId: '499743383793',
    projectId: 'kidneycancerdetection',
    storageBucket: 'kidneycancerdetection.appspot.com',
    iosBundleId: 'com.example.kidneyCancerDetection',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIxViD-Gay3M7tgbtttEqXConRP0zxtQc',
    appId: '1:499743383793:web:2b0fe4fcee4675dab64950',
    messagingSenderId: '499743383793',
    projectId: 'kidneycancerdetection',
    authDomain: 'kidneycancerdetection.firebaseapp.com',
    storageBucket: 'kidneycancerdetection.appspot.com',
  );
}
