import 'package:flutter/material.dart';

class GoalName extends StatelessWidget {
  final String name;
  const GoalName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
