import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/home_screen/event_bubble.dart';
import '../../constants/upcoming_events.dart';

class UpcomingEvents extends StatefulWidget {
  final int eventsOnDisplay;

  const UpcomingEvents({
    this.eventsOnDisplay = defualtEventsOnDisplay,
    Key? key,
  }) : super(key: key);

  static const int defualtEventsOnDisplay = 3;

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
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: Get.width / widget.eventsOnDisplay,
        itemBuilder: (context, index) {
          return EventBubble(
            event: "event: $index",
            days: "$index",
            date:
                "${1 + index % 31}/${(index / 30).floor() % 13}/${22 + (index / 365).floor()}",
            type: index % 3 == 0
                ? UpcomingEventTypes.celebration
                : index % 3 == 1
                    ? UpcomingEventTypes.vacation
                    : UpcomingEventTypes.study,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
