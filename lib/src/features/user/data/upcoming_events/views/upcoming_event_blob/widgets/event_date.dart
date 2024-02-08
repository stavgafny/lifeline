import 'package:flutter/material.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../../../models/upcoming_event_model.dart';

class EventDate extends StatelessWidget {
  static const double textSize = 11.0;

  final UpcomingEventModel model;

  const EventDate({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Text(
      model.dateTime.formatDDMMYYYY(),
      style: const TextStyle(fontSize: textSize),
    );
  }
}
