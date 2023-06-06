import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final Color color;
  const TextDivider({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Expanded(child: Divider(color: color));

    return Row(
      children: <Widget>[
        divider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "OR",
            style: TextStyle(color: color),
          ),
        ),
        divider,
      ],
    );
  }
}
