import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/upcoming_event_model.dart';

class EventType extends StatelessWidget {
  static const double _imageOpacity = .5;

  final UpcomingEventModel model;

  const EventType({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: model.type.value,
          opacity: _imageOpacity,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Transform.translate(
              // Fix google fonts 'pacifico' relative line height offset
              offset: const Offset(0, -2),
              child: Text(
                "1",
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
