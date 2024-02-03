import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/upcoming_events_controller.dart';
import './widgets/ue_list_view.dart';
import './widgets/ue_error.dart';
import './widgets/ue_loading.dart';

class UpcomingEventsListView extends ConsumerWidget {
  const UpcomingEventsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(upcomingEventsProvider).when(
          data: (upcomingEvents) => UEListView(upcomingEvents: upcomingEvents),
          error: (error, stackTrace) => UEError(error: error),
          loading: () => const UELoading(),
        );
  }
}
