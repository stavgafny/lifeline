import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../routes/route_pages.dart';
import '../../services/auth/user_auth.dart';
import '../../services/goal_tracker/goal_tracker_foreground_task.dart';

import './swipeables_screens/dashboard_screen.dart';
import './swipeables_screens/home_screen.dart';
import './swipeables_screens/timeline_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int screenIndex = 1;

  late PageController pageController = PageController(initialPage: screenIndex);

  @override
  Widget build(BuildContext context) {
    if (!UserAuth.exist) {
      Future.delayed(const Duration(seconds: 0))
          .then((value) => Get.toNamed(RoutePage.error));
    }

    return GoalTrackerForegroundTask(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Lifeline", style: GoogleFonts.pacifico(fontSize: 32.0)),
          leading: GestureDetector(
            onTap: () {
              UserAuth.signOut();
            },
            child: const Icon(Icons.people),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
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
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (int index) {
            setState(() => screenIndex = index);
          },
          children: const [
            DashboardScreen(),
            HomeScreen(),
            TimelineScreen(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: Theme.of(context).navigationBarTheme.backgroundColor!,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          animationDuration: const Duration(milliseconds: 250),
          index: screenIndex,
          onTap: (int index) {
            pageController.jumpToPage(index);
          },
          items: [
            Icon(
              Icons.dashboard,
              color: Theme.of(context).navigationBarTheme.indicatorColor,
            ),
            Icon(
              Icons.home,
              color: Theme.of(context).navigationBarTheme.indicatorColor,
            ),
            Icon(
              Icons.timeline_rounded,
              color: Theme.of(context).navigationBarTheme.indicatorColor,
            ),
          ],
        ),
      ),
    );
  }
}
