import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants/firebase_options.dart';

class _FirebaseConfig {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

final firebaseConfig = _FirebaseConfig();
