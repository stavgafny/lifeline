import 'package:flutter/material.dart';
import '../../../models/upcoming_event_model.dart';

class EventDate extends StatelessWidget {
  final UpcomingEventModel model;

  const EventDate({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "12/12/12",
      style: TextStyle(fontSize: 12.0),
    );
  }
}
