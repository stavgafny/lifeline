import 'dart:math';

import 'package:flutter/material.dart';
import '../views/upcoming_event_blob/upcoming_event_blob.dart';

class UpcomingEventsBuildProperties {
  final double maxHeight;
  final double height;
  final double itemSize;
  UpcomingEventsBuildProperties({
    required this.maxHeight,
    required this.height,
    required this.itemSize,
  });
}

class UpcomingEventsBuildHelper {
  static const double _maxHeightFromScreen = .25; // 1/4 of the screen
  static const double _upcomingEventBlobMinSize = 130.0;
  static const double _viewPadding = 4.0;

  static UpcomingEventsBuildProperties getBuildProperties(
    BuildContext context, {
    required int upcomingEventsNumber,
  }) {
    // Gets screen dimensions
    final screenSize = MediaQuery.of(context).size;

    // Max height
    final maxHeight = screenSize.height * _maxHeightFromScreen;

    // Number of upcoming events displayed at once
    final presentedNumber = screenSize.width ~/ _upcomingEventBlobMinSize;

    final size = screenSize.width / min(presentedNumber, upcomingEventsNumber);

    return UpcomingEventsBuildProperties(
      maxHeight: maxHeight,
      height: size + UpcomingEventBlob.totalTextSize - _viewPadding,
      itemSize: size,
    );
  }
}
