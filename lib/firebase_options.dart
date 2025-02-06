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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEAd_SY8NHe6kP7S9ilgoVuK7ubyepr8o',
    appId: '1:610805260869:web:0e0616b0a06616cc37792c',
    messagingSenderId: '610805260869',
    projectId: 'altaguardia-hub',
    authDomain: 'altaguardia-hub.firebaseapp.com',
    databaseURL: 'https://altaguardia-hub-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'altaguardia-hub.firebasestorage.app',
    measurementId: 'G-L7LCXCK3SV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeWlb_op4umzEz5vGg17YeDwEQi2C0E6I',
    appId: '1:610805260869:android:e1b57f97da5c34ba37792c',
    messagingSenderId: '610805260869',
    projectId: 'altaguardia-hub',
    databaseURL: 'https://altaguardia-hub-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'altaguardia-hub.firebasestorage.app',
  );

}