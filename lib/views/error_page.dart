import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route_pages.dart';
import '../services/user_auth.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Whoops!", style: TextStyle(fontSize: 50.0)),
            const Text("Something went wrong",
                style: TextStyle(fontSize: 20.0)),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                onPressed: () {
                  UserAuth.signOut();
                  Get.toNamed(RoutePage.login);
                },
                child: const Text("Go Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
