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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBrfZ7kpTU7AFEuNcR08SvcSSZCy8GrMpI',
    appId: '1:210169006561:web:6a427a336fdf9228c3aaa0',
    messagingSenderId: '210169006561',
    projectId: 'flalog',
    authDomain: 'flalog.firebaseapp.com',
    storageBucket: 'flalog.appspot.com',
    measurementId: 'G-ZHVV1S9JPF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWf7r8Iy9hFT2sX5PY8t65COpAfwlQiUg',
    appId: '1:210169006561:android:497febf56b77ea8ac3aaa0',
    messagingSenderId: '210169006561',
    projectId: 'flalog',
    storageBucket: 'flalog.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_gaH43R2x2sCsoP107bMMzopnjvcTgU8',
    appId: '1:210169006561:ios:58d11cd420fd82eec3aaa0',
    messagingSenderId: '210169006561',
    projectId: 'flalog',
    storageBucket: 'flalog.appspot.com',
    androidClientId: '210169006561-95ki9svd74irbhjts0vobd86johl9h48.apps.googleusercontent.com',
    iosClientId: '210169006561-arn4hemansh85ppoqmvdomrkh5gobmnj.apps.googleusercontent.com',
    iosBundleId: 'com.reinvent.flalog',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_gaH43R2x2sCsoP107bMMzopnjvcTgU8',
    appId: '1:210169006561:ios:58d11cd420fd82eec3aaa0',
    messagingSenderId: '210169006561',
    projectId: 'flalog',
    storageBucket: 'flalog.appspot.com',
    androidClientId: '210169006561-95ki9svd74irbhjts0vobd86johl9h48.apps.googleusercontent.com',
    iosClientId: '210169006561-arn4hemansh85ppoqmvdomrkh5gobmnj.apps.googleusercontent.com',
    iosBundleId: 'com.reinvent.flalog',
  );
}
