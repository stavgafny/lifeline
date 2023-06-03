import 'package:flutter/material.dart';
import './src/configs/app_config.dart';
import './src/configs/firebase_config.dart';
import './src/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appConfig.init();
  await firebaseConfig.init();

  runApp(const MainApp());
}
