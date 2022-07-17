import 'package:flutter/material.dart';

const _celebration = AssetImage("assets/upcoming_events/celebration.png");
const _vacation = AssetImage("assets/upcoming_events/vacation.png");
const _study = AssetImage("assets/upcoming_events/study.png");

enum UpcomingEventTypes {
  celebration,
  vacation,
  study,
}

AssetImage getUpcomingEvent(UpcomingEventTypes type) {
  switch (type) {
    case UpcomingEventTypes.celebration:
      return _celebration;
    case UpcomingEventTypes.vacation:
      return _vacation;
    case UpcomingEventTypes.study:
      return _study;
  }
}
