import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/router/routes/app_routes.dart';

import '../../controllers/upcoming_event_controller.dart';
import '../../controllers/upcoming_events_controller.dart';
import '../../utils/upcoming_events_build_helper.dart';
import '../upcoming_event_blob/upcoming_event_blob.dart';
import './widgets/add_upcoming_event_button.dart';

class UpcomingEventsListView extends ConsumerWidget {
  const UpcomingEventsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider);

    final buildProperties = UpcomingEventsBuildHelper.getBuildProperties(
      context,
      upcomingEventsNumber: upcomingEvents.length,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: buildProperties.maxHeight),
        child: SizedBox(
          width: double.infinity,
          height: buildProperties.height,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(upcomingEventsProvider.notifier)
                  .swap(oldIndex, newIndex);
            },
            footer: AddUpcomingEventButton(
              size: buildProperties.itemSize,
              standalone: upcomingEvents.isEmpty,
            ),
            children: [
              for (int i = 0; i < upcomingEvents.length; i++)
                _buildUpcomingEvent(
                  context,
                  size: buildProperties.itemSize,
                  upcomingEvent: upcomingEvents[i],
                  onTap: () {
                    {
                      context.pushNamed(
                        AppRoutes.upcomingEvent,
                        pathParameters: {'ue': "$i"},
                      );
                    }
                  },
                )
            ],
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEvent(
    BuildContext context, {
    required double size,
    required UpcomingEventProvider upcomingEvent,
    required void Function() onTap,
  }) {
    return SizedBox(
      key: ValueKey(upcomingEvent),
      width: size,
      child: UpcomingEventBlob(
        provider: upcomingEvent,
        onTap: onTap,
      ),
    );
  }
}
