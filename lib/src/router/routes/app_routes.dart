import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/signin/signin_screen.dart';
import '../../features/authentication/signup/signup_screen.dart';
import '../../features/authentication/forgot_password/forgot_password_screen.dart';

class AppRoutes {
  static const String initial = "/";
  static const String error = "/error";
  static const String signin = "/signin";
  static const String signup = "/signup";
  static const String emailVerification = "/email-verification";
  static const String forgotPassword = "/forgot-password";
  static const String home = "/home";

  static const _nonAuthAllowed = <String>[
    signin,
    signup,
    emailVerification,
    forgotPassword,
  ];

  static isNonAuthAllowed(String route) => _nonAuthAllowed.contains(route);

  static List<RouteBase> routes = [
    GoRoute(
      path: initial,
      builder: (context, state) => const _Splash(),
    ),
    GoRoute(
      path: signin,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      path: signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: home,
      builder: (context, state) => const _Home(),
    ),
  ];
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
