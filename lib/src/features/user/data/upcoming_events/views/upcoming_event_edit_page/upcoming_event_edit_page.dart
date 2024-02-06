import 'package:flutter/material.dart';
import '../../models/upcoming_event_model.dart';
import './widgets/type_edit.dart';
import './widgets/name_edit.dart';
import './widgets/date_days_time_edit.dart';
import './widgets/details_edit.dart';

class UpcomingEventEditPage extends StatelessWidget {
  final UpcomingEventModel model;

  const UpcomingEventEditPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TypeEdit(model: model),
          NameEdit(model: model),
          DateDaysTimeEdit(model: model),
          DetailsEdit(
              text: [for (int i = 0; i < 100; i++) "123\r\n"].join(".")),
        ],
      ),
    );
  }
}
