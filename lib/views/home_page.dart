import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route_pages.dart';
import '../services/user_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!UserAuth.exist) {
      Future.delayed(const Duration(seconds: 0))
          .then((value) => Get.toNamed(RoutePage.error));
    }

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
                onPressed: () => UserAuth.signOut(),
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
