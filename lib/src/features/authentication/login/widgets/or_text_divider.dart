import 'package:flutter/material.dart';

class OrTextDivider extends StatelessWidget {
  const OrTextDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSecondary;
    final divider = Expanded(child: Divider(color: color));

    return Column(
      children: [
        const SizedBox(height: 10.0),
        Row(
          children: [
            divider,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("OR", style: TextStyle(color: color)),
            ),
            divider,
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
