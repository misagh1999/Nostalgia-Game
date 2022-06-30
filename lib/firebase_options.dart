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
    apiKey: 'AIzaSyD8Nx3EMUMmMcT0_NJlKtMEu2aEnRTfXwk',
    appId: '1:105655490920:web:b616bf04b7f2d2ca671edd',
    messagingSenderId: '105655490920',
    projectId: 'handy-handy',
    authDomain: 'handy-handy.firebaseapp.com',
    storageBucket: 'handy-handy.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCK22OJoGQwLWaPVIW5kgbBxMoHh6gJTvU',
    appId: '1:105655490920:android:955bef5f09e27f3d671edd',
    messagingSenderId: '105655490920',
    projectId: 'handy-handy',
    storageBucket: 'handy-handy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYaECby2pUyfbL2PJBeuoK4jwwELeUzgo',
    appId: '1:105655490920:ios:062ff0f73e5073b9671edd',
    messagingSenderId: '105655490920',
    projectId: 'handy-handy',
    storageBucket: 'handy-handy.appspot.com',
    iosClientId: '105655490920-pe2jj9grra2alg3shbefqf5pd9ahnple.apps.googleusercontent.com',
    iosBundleId: 'com.example.handyDandyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYaECby2pUyfbL2PJBeuoK4jwwELeUzgo',
    appId: '1:105655490920:ios:062ff0f73e5073b9671edd',
    messagingSenderId: '105655490920',
    projectId: 'handy-handy',
    storageBucket: 'handy-handy.appspot.com',
    iosClientId: '105655490920-pe2jj9grra2alg3shbefqf5pd9ahnple.apps.googleusercontent.com',
    iosBundleId: 'com.example.handyDandyApp',
  );
}