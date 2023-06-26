import 'package:flutter/material.dart';
import './widgets/top_appbar.dart';
import './widgets/bottom_navbar.dart';

class ShellScreen extends StatelessWidget {
  final Widget body;
  final String location;
  const ShellScreen({super.key, required this.body, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppbar(),
      body: body,
      bottomNavigationBar: BottomNavbar(initialRoute: location),
    );
  }
}
