import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeline/views/login_page.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            return Scaffold(
              appBar: AppBar(
                title: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text("Sign Out"),
                ),
              ),
              body: Center(
                child: Text("Signed in as: ${user?.email}"),
              ),
            );
          }
          return const LoginPage();
        },
      ),
    );
  }
}
