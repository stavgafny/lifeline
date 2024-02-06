import 'package:flutter/material.dart';

class DetailsEdit extends StatelessWidget {
  final String text;
  const DetailsEdit({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Scrollbar(
        child: TextField(
          maxLines: null,
          controller: TextEditingController(text: text),
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          decoration: const InputDecoration(
            hintText: 'Event details',
            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
