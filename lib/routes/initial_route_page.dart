import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/route_pages.dart';
import '../services/user_auth.dart';

class InitialRoutePage extends StatelessWidget {
  const InitialRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    ! signedUnverified
    In the case that the user didn't verify his email and re-launched the app again
    It will log him off the account (to prevent verify email page on launch)
    * True if user account signed but yet to be verified
    */
    bool launchedUnverified = UserAuth.exist && !UserAuth.verified;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (UserAuth.exist && !launchedUnverified) {
        Get.offAllNamed(
          UserAuth.verified ? RoutePage.home : RoutePage.emailVerification,
        );
      } else {
        if (launchedUnverified) {
          UserAuth.signOut();
          launchedUnverified = false;
        }
        Get.offAllNamed(RoutePage.login);
      }
    });
    // Scaffold placeholder for state change
    return const Scaffold();
  }
}
