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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPfvOVMZJJ_eyJ_Yl6SHAv3iDgUoPFZgM',
    appId: '1:173362786937:android:fb285e9c6bec13a52f9aa8',
    messagingSenderId: '173362786937',
    projectId: 'fir-series-f471a',
    storageBucket: 'fir-series-f471a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZu6TUk3irea4A2_mdb-n8SnakDjmhE9U',
    appId: '1:173362786937:ios:48043467d69e04852f9aa8',
    messagingSenderId: '173362786937',
    projectId: 'fir-series-f471a',
    storageBucket: 'fir-series-f471a.appspot.com',
    androidClientId: '173362786937-v0f6tqnjrcp9j85hvkqcfb88hl0cq64a.apps.googleusercontent.com',
    iosClientId: '173362786937-acccafughatd40hueeonburugfdcvg0q.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
