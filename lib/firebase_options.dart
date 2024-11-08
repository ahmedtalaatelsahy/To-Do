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
    apiKey: 'AIzaSyAFm52o6c8-__mmnZ87Bx3WzGbZq_G74DA',
    appId: '1:101764320357:web:ba21c58edd7221b32d4a8c',
    messagingSenderId: '101764320357',
    projectId: 'to-do-dd158',
    authDomain: 'to-do-dd158.firebaseapp.com',
    storageBucket: 'to-do-dd158.firebasestorage.app',
    measurementId: 'G-D0JBRJP5SN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAGZnEPUveZoUNSU3Pn1nfx8urmsa-Ad8',
    appId: '1:101764320357:android:27bf9fbbf1717d932d4a8c',
    messagingSenderId: '101764320357',
    projectId: 'to-do-dd158',
    storageBucket: 'to-do-dd158.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPBuP_kdXP30yhmRuaB_P-VM9sMF6zdl0',
    appId: '1:101764320357:ios:fae41f8a9b3cb2262d4a8c',
    messagingSenderId: '101764320357',
    projectId: 'to-do-dd158',
    storageBucket: 'to-do-dd158.firebasestorage.app',
    iosBundleId: 'com.example.toDoApp',
  );

}