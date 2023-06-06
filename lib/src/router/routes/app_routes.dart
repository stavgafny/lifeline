import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/authentication/login/login_screen.dart';

class AppRoutes {
  static const String initial = "/";
  static const String error = "/error";
  static const String login = "/login";
  static const String register = "/register";
  static const String emailVerification = "/email-verification";
  static const String forgotPassword = "/forgot-password";
  static const String home = "/home";

  static List<RouteBase> routes = [
    GoRoute(path: initial, builder: (context, state) => const _Splash()),
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: home, builder: (context, state) => const _Home()),
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

class _Login extends StatelessWidget {
  const _Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Login"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final GoogleSignIn googleSignIn = GoogleSignIn();
          final GoogleSignInAccount? googleSignInAccount =
              await googleSignIn.signIn();
          final GoogleSignInAuthentication googleSignInAuth =
              await googleSignInAccount!.authentication;

          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth.accessToken,
            idToken: googleSignInAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
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
