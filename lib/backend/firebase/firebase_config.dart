import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJVchCJPAZchVhIZk1qJr7L3R3Sufym_g",
            authDomain: "little-bittle-7a115.firebaseapp.com",
            projectId: "little-bittle-7a115",
            storageBucket: "little-bittle-7a115.appspot.com",
            messagingSenderId: "641366725380",
            appId: "1:641366725380:web:df482a1cea733d4ebf7651",
            measurementId: "G-VLRKRSXHLG"));
  } else {
    await Firebase.initializeApp();
  }
}
