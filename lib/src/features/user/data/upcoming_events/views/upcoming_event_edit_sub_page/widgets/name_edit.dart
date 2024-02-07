import 'package:flutter/material.dart';
import '../../../models/upcoming_event_model.dart';

class NameEdit extends StatelessWidget {
  final UpcomingEventModel model;

  const NameEdit({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: TextEditingController(text: model.name),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: "Name",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
            ),
          ),
          contentPadding: const EdgeInsets.all(6.0),
        ),
      ),
    );
  }
}
