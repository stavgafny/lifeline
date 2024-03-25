import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/router/routes/app_routes.dart';
import '../../../timeline/models/timeline_model.dart';
import '../../timeline_item_view/timeline_item_view.dart';

class TimelinesGrid extends ConsumerWidget {
  static const EdgeInsets _padding = EdgeInsets.all(10.0);
  static const double _gridGap = 20.0;

  final List<TimelineModel> timelines;
  const TimelinesGrid({super.key, required this.timelines});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      padding: _padding,
      crossAxisSpacing: _gridGap,
      mainAxisSpacing: _gridGap,
      children: [
        for (final timeline in timelines)
          TimelineItemView(
            timeline: timeline,
            onTap: () {
              context.pushNamed(
                AppRoutes.timeline,
                pathParameters: {"timeline": timeline.name},
              );
            },
          )
      ],
    );
  }
}
