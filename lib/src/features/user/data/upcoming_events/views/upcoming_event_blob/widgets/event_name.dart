import 'package:flutter/material.dart';
import '../../../models/upcoming_event_model.dart';

class EventName extends StatelessWidget {
  static const double textSize = 20.0;

  final UpcomingEventModel model;

  const EventName({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        model.name,
        style: const TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
