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
    apiKey: 'AIzaSyARJI360GLkhtd73TN_IkswVjySApdR4pY',
    appId: '1:878310105620:web:ae52f6959ccda9d3537d01',
    messagingSenderId: '878310105620',
    projectId: 'hoba-7e83d',
    authDomain: 'hoba-7e83d.firebaseapp.com',
    databaseURL: 'https://hoba-7e83d-default-rtdb.firebaseio.com',
    storageBucket: 'hoba-7e83d.appspot.com',
    measurementId: 'G-WX2794BD1Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdnH_Jp7vQq4kn50Uzlzv5wAaIoMHx3qE',
    appId: '1:878310105620:android:9c3859fa8e2e35f4537d01',
    messagingSenderId: '878310105620',
    projectId: 'hoba-7e83d',
    databaseURL: 'https://hoba-7e83d-default-rtdb.firebaseio.com',
    storageBucket: 'hoba-7e83d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNmFb7QhhyDvAp40VEgrKjnpfNbboxx-I',
    appId: '1:878310105620:ios:17be9eff8bce3460537d01',
    messagingSenderId: '878310105620',
    projectId: 'hoba-7e83d',
    databaseURL: 'https://hoba-7e83d-default-rtdb.firebaseio.com',
    storageBucket: 'hoba-7e83d.appspot.com',
    iosClientId: '878310105620-ak58k4ifol2h410auvrpssi49qk4o3en.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCNmFb7QhhyDvAp40VEgrKjnpfNbboxx-I',
    appId: '1:878310105620:ios:17be9eff8bce3460537d01',
    messagingSenderId: '878310105620',
    projectId: 'hoba-7e83d',
    databaseURL: 'https://hoba-7e83d-default-rtdb.firebaseio.com',
    storageBucket: 'hoba-7e83d.appspot.com',
    iosClientId: '878310105620-ak58k4ifol2h410auvrpssi49qk4o3en.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterproject',
  );
}
