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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk_i10lmnj0H2k2ZjYjAfplsYWZ58XF60',
    appId: '1:52442539439:android:a0b66db2769e726338fb5a',
    messagingSenderId: '52442539439',
    projectId: 'flutter-chat-app-786fa',
    storageBucket: 'flutter-chat-app-786fa.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBM_Mq1T4xXmR5W5f7jFb3BZLbeE4zVuf8',
    appId: '1:52442539439:ios:d63eb404c1e4249f38fb5a',
    messagingSenderId: '52442539439',
    projectId: 'flutter-chat-app-786fa',
    storageBucket: 'flutter-chat-app-786fa.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCvw-JFSstUmDRAkpGhIYh9QWoFkodkTQ4',
    appId: '1:52442539439:web:149a03f9afaef56c38fb5a',
    messagingSenderId: '52442539439',
    projectId: 'flutter-chat-app-786fa',
    authDomain: 'flutter-chat-app-786fa.firebaseapp.com',
    storageBucket: 'flutter-chat-app-786fa.firebasestorage.app',
  );

}