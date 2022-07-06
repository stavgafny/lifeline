import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/route_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';

Widget onError() {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const Text("Whoops!", style: TextStyle(fontSize: 50.0)),
              const Text("Something went wrong",
                  style: TextStyle(fontSize: 20.0)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.toNamed(RoutePage.login);
                  },
                  child: const Text("Go Back"),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Get.arguments;
    if (user == null) return onError();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Lifeline", style: GoogleFonts.pacifico(fontSize: 32.0)),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.people),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.menu),
            ),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Theme.of(context).appBarTheme.backgroundColor!,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                },
                child: const Text("Change Theme"),
              ),
              SizedBox(
                height: Get.height / 2,
              ),
              ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
