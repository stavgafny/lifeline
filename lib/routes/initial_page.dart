import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/route_pages.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAndToNamed(RoutePage.login);
      } else {
        Get.offAndToNamed(RoutePage.home, arguments: user);
      }
    });
    // Scaffold placeholder for state change
    return const Scaffold();
  }
}
