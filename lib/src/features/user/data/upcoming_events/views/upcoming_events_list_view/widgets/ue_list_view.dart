import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/global_time.dart';
import 'package:lifeline/src/widgets/snackbars.dart';
import '../../../controllers/upcoming_event_controller.dart';
import '../../../controllers/upcoming_events_controller.dart';
import '../../../models/upcoming_event_model.dart';
import '../../../utils/upcoming_events_build_helper.dart';
import '../../upcoming_event_blob/upcoming_event_blob.dart';
import '../../upcoming_event_edit_sub_page/upcoming_event_edit_sub_page.dart';

class UEListView extends ConsumerStatefulWidget {
  final List<UpcomingEventProvider> upcomingEvents;

  const UEListView({super.key, required this.upcomingEvents});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UEListViewState();
}

class _UEListViewState extends ConsumerState<UEListView> {
  StreamSubscription<void>? _midnightListener;

  UpcomingEventsController get _upcomingEventsController =>
      ref.read(upcomingEventsProvider.notifier);

  @override
  void initState() {
    super.initState();
    _midnightListener = GlobalTime.atMidnight().listen((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingEvents.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: UpcomingEventBlob.addButton(
          onTap: () {
            final newUpcomingEvent = UpcomingEventProvider(
              (ref) => UpcomingEventController(
                UpcomingEventModel.empty(),
              ),
            );
            _editUpcomingEvent(newUpcomingEvent);
          },
        ),
      );
    }

    final buildProperties = UpcomingEventsBuildHelper.getBuildProperties(
      context,
      upcomingEventsNumber: widget.upcomingEvents.length,
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
              _upcomingEventsController.swap(oldIndex, newIndex);
            },
            footer: SizedBox(
              width: buildProperties.itemSize,
              child: UpcomingEventBlob.addButton(
                onTap: () {
                  final newUpcomingEvent = UpcomingEventProvider(
                    (ref) => UpcomingEventController(
                      UpcomingEventModel.empty(),
                    ),
                  );
                  _editUpcomingEvent(newUpcomingEvent);
                },
              ),
            ),
            children: [
              for (final upcomingEvent in widget.upcomingEvents)
                _buildUpcomingEvent(
                  context,
                  size: buildProperties.itemSize,
                  upcomingEvent: upcomingEvent,
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
  }) {
    return SizedBox(
      key: ValueKey(upcomingEvent),
      width: size,
      child: UpcomingEventBlob(
        provider: upcomingEvent,
        onTap: () => _editUpcomingEvent(upcomingEvent),
      ),
    );
  }

  void _editUpcomingEvent(UpcomingEventProvider upcomingEvent) {
    UndoSnackBar.clear();
    UpcomingEventEditSubPage.display(
      context,
      upcomingEvent: upcomingEvent,
      onDelete: () => _onDeleteUpcomingEvent(upcomingEvent),
    );
  }

  void _onDeleteUpcomingEvent(UpcomingEventProvider upcomingEvent) {
    final index = _upcomingEventsController.indexOf(upcomingEvent);
    if (index == -1) return;
    final name = ref.read(upcomingEvent).name;
    _upcomingEventsController.remove(upcomingEvent);
    UndoSnackBar(
      text: "Removed $name",
      onUndoResult: (undoPressed) {
        if (undoPressed) {
          // If switched to a different screen and tapped undo while closing
          if (!mounted) return;
          _upcomingEventsController.insert(upcomingEvent, index);
        }
      },
    ).display(context, override: true);
  }

  @override
  void dispose() {
    UndoSnackBar.clear();
    _midnightListener?.cancel();
    super.dispose();
  }
}
