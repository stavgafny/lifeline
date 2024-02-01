import 'package:flutter/material.dart';

import '../../models/upcoming_event_model.dart';
import './widgets/event_date.dart';
import './widgets/event_type.dart';
import './widgets/event_name.dart';

class UpcomingEventBlob extends StatelessWidget {
  final UpcomingEventModel model;

  const UpcomingEventBlob({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventDate(model: model),
        EventType(model: model),
        EventName(model: model),
      ],
    );
  }
}
