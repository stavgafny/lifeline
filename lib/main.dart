import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifeline/constants/firebase_options.dart';
import 'package:lifeline/constants/theme_data.dart';
import 'package:lifeline/views/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String title = "Lifeline";

  //!ROOT
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: lightTheme,
      home: const LoginPage(),
    );
  }
}
