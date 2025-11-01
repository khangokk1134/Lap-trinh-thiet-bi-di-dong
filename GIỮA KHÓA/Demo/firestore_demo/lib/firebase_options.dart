import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCkC0RMMCTGWd2YTh0898tLU7rfRq3TDrs',
    appId: '1:765394760447:web:10f3d3d515105df8c812ca',
    messagingSenderId: '765394760447',
    projectId: 'firestore-demo-khang',
    authDomain: 'firestore-demo-khang.firebaseapp.com',
    storageBucket: 'firestore-demo-khang.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzzm3zpUor46zov2Ev7H9By7A54ekvX7Y',
    appId: '1:765394760447:android:c0b3463668f02823c812ca',
    messagingSenderId: '765394760447',
    projectId: 'firestore-demo-khang',
    storageBucket: 'firestore-demo-khang.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCvx4L4z5hxTx2oHLfjDfYIBL5aW7Vlss',
    appId: '1:765394760447:ios:ce5f2f2fe4efe998c812ca',
    messagingSenderId: '765394760447',
    projectId: 'firestore-demo-khang',
    storageBucket: 'firestore-demo-khang.firebasestorage.app',
    iosBundleId: 'com.example.firestoreDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCvx4L4z5hxTx2oHLfjDfYIBL5aW7Vlss',
    appId: '1:765394760447:ios:ce5f2f2fe4efe998c812ca',
    messagingSenderId: '765394760447',
    projectId: 'firestore-demo-khang',
    storageBucket: 'firestore-demo-khang.firebasestorage.app',
    iosBundleId: 'com.example.firestoreDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkC0RMMCTGWd2YTh0898tLU7rfRq3TDrs',
    appId: '1:765394760447:web:79a4b94e66e1d6e4c812ca',
    messagingSenderId: '765394760447',
    projectId: 'firestore-demo-khang',
    authDomain: 'firestore-demo-khang.firebaseapp.com',
    storageBucket: 'firestore-demo-khang.firebasestorage.app',
  );
}
