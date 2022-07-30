import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _celebration = AssetImage("assets/upcoming_events/celebration.png");
const _vacation = AssetImage("assets/upcoming_events/vacation.png");
const _education = AssetImage("assets/upcoming_events/education.png");
const _movie = AssetImage("assets/upcoming_events/movie.png");
const _grocery = AssetImage("assets/upcoming_events/grocery.png");
const _shopping = AssetImage("assets/upcoming_events/shopping.png");
const _trip = AssetImage("assets/upcoming_events/trip.png");
const _workout = AssetImage("assets/upcoming_events/workout.png");
const _yoga = AssetImage("assets/upcoming_events/yoga.png");

enum UpcomingEventTypes {
  celebration,
  vacation,
  education,
  movie,
  grocery,
  shopping,
  trip,
  workout,
  yoga,
}

AssetImage getUpcomingEventImage(UpcomingEventTypes type) {
  switch (type) {
    case UpcomingEventTypes.celebration:
      return _celebration;
    case UpcomingEventTypes.vacation:
      return _vacation;
    case UpcomingEventTypes.education:
      return _education;
    case UpcomingEventTypes.movie:
      return _movie;
    case UpcomingEventTypes.grocery:
      return _grocery;
    case UpcomingEventTypes.shopping:
      return _shopping;
    case UpcomingEventTypes.trip:
      return _trip;
    case UpcomingEventTypes.workout:
      return _workout;
    case UpcomingEventTypes.yoga:
      return _yoga;
  }
}

class UpcomingEvent extends StatelessWidget {
  final String days;
  final String event;
  final String date;
  final UpcomingEventTypes type;

  const UpcomingEvent({
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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: getUpcomingEventImage(type),
                opacity: 0.5,
              ),
            ),
            child: Text(
              days,
              style: GoogleFonts.pacifico(fontSize: 50.0, height: -(1 / 3.0)),
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
