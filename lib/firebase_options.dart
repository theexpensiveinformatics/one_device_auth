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
    apiKey: 'AIzaSyDggPAM9uVaOF4GQx_89E-yP4Ysm0qe-Q4',
    appId: '1:649118441184:web:62a5beeafdf616fcd47a85',
    messagingSenderId: '649118441184',
    projectId: 'one-device-auth',
    authDomain: 'one-device-auth.firebaseapp.com',
    storageBucket: 'one-device-auth.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9Cgt6haWr2MmBJCi59NJ4-Uru8ChfRr0',
    appId: '1:649118441184:android:69c99324ebd85bbfd47a85',
    messagingSenderId: '649118441184',
    projectId: 'one-device-auth',
    storageBucket: 'one-device-auth.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBap6TSHmKQcvglx1YmJBNkNYsPo07YbHY',
    appId: '1:649118441184:ios:3086e921389f9c5ad47a85',
    messagingSenderId: '649118441184',
    projectId: 'one-device-auth',
    storageBucket: 'one-device-auth.firebasestorage.app',
    iosBundleId: 'com.example.oneDeviceAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBap6TSHmKQcvglx1YmJBNkNYsPo07YbHY',
    appId: '1:649118441184:ios:3086e921389f9c5ad47a85',
    messagingSenderId: '649118441184',
    projectId: 'one-device-auth',
    storageBucket: 'one-device-auth.firebasestorage.app',
    iosBundleId: 'com.example.oneDeviceAuth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDggPAM9uVaOF4GQx_89E-yP4Ysm0qe-Q4',
    appId: '1:649118441184:web:c0c917a240cd8ef1d47a85',
    messagingSenderId: '649118441184',
    projectId: 'one-device-auth',
    authDomain: 'one-device-auth.firebaseapp.com',
    storageBucket: 'one-device-auth.firebasestorage.app',
  );
}
