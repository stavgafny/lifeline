import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../upcoming_event.dart';

class UpcomingEvents extends StatefulWidget {
  static const double defaultHeight = 150.0;
  static const int defaultUpcomingEventsOnDisplay = 3;

  final double height;
  final int upcomingEventsOnDisplay;

  const UpcomingEvents({
    this.height = defaultHeight,
    this.upcomingEventsOnDisplay = defaultUpcomingEventsOnDisplay,
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: Get.width / widget.upcomingEventsOnDisplay,
        itemBuilder: (context, index) {
          return UpcomingEvent(
            event: "event: $index",
            days: "$index",
            date:
                "${1 + index % 31}/${(index / 30).floor() % 13}/${22 + (index / 365).floor()}",
            type: UpcomingEventTypes
                .values[index % UpcomingEventTypes.values.length],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
