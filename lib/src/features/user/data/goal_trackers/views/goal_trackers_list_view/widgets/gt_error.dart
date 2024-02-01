import 'package:flutter/material.dart';

class GTError extends StatelessWidget {
  final Object error;

  const GTError({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final errorMsg = error.toString();
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Failed to load goal trackers",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text("\"$errorMsg\"", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
