import 'package:flutter/material.dart';

class OrTextDivider extends StatelessWidget {
  const OrTextDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSecondary;
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
