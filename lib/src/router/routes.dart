import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/auth_provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    navigatorKey: _navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: "/splash",
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Home()),
      GoRoute(path: "/login", builder: (context, state) => const Login()),
      GoRoute(path: "/splash", builder: (context, state) => const Splash()),
    ],
    redirect: (context, state) {
      if (authState.asData == null) {
        return null;
      }
      final user = authState.value;
      return user != null ? "/" : "/login";
    },
  );
});

class Home extends StatelessWidget {
  const Home({super.key});

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

class Login extends StatelessWidget {
  const Login({super.key});

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

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
