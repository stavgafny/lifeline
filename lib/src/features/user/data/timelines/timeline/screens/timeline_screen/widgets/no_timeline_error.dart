import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/tappable_text.dart';

class NoTimelineError extends StatelessWidget {
  const NoTimelineError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("There is no such timeline"),
            const SizedBox(height: 60.0),
            TappableText(
              text: "Go Back",
              onTap: () => Navigator.of(context).maybePop(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
