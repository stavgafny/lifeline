import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/authentication/signin/signin_screen.dart';

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
    GoRoute(path: initial, builder: (context, state) => const _Splash()),
    GoRoute(path: signin, builder: (context, state) => const SigninScreen()),
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
