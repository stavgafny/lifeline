import 'package:flutter/material.dart';
import '../../models/upcoming_event_model.dart';

class UpcomingEventEditPage extends StatelessWidget {
  final UpcomingEventModel model;

  const UpcomingEventEditPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.75,
            child: Hero(
              tag: model,
              transitionOnUserGestures: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: model.type.value,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
