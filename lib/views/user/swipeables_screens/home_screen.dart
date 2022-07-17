import 'package:flutter/material.dart';
import '../../../widgets/home_screen/upcoming_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 30.0),
        UpcomingEvents(),
      ],
    );
  }
}
