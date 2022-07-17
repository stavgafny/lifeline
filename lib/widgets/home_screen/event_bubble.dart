import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/upcoming_events.dart';

class EventBubble extends StatelessWidget {
  final String days;
  final String event;
  final String date;
  final UpcomingEventTypes type;

  const EventBubble({
    required this.event,
    required this.days,
    required this.date,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            date,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: getUpcomingEvent(type),
                opacity: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                days,
                style: GoogleFonts.pacifico(fontSize: 50.0),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            event,
            style: const TextStyle(fontSize: 20.0),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
        ),
      ],
    );
  }
}
