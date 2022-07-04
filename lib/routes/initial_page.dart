import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/routes/route_pages.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.toNamed(RoutePage.login);
      } else {
        Get.toNamed(RoutePage.home, arguments: user);
      }
    });
    // Scaffold placeholder for state change
    return const Scaffold();
  }
}
