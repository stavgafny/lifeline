import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/widgets/expanded_section.dart';
import '../../controllers/upcoming_event_controller.dart';
import '../../controllers/upcoming_events_controller.dart';
import '../../models/upcoming_event_model.dart';
import './widgets/type_edit.dart';
import './widgets/name_edit.dart';
import './widgets/date_days_time_edit.dart';
import './widgets/details_edit.dart';
import './widgets/action_buttons.dart';
import './widgets/unsaved_changes_wrapper.dart';

class UpcomingEventEditScreen extends ConsumerStatefulWidget {
  final int upcomingEventIndex;

  const UpcomingEventEditScreen({super.key, required this.upcomingEventIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpcomingEventEditScreenState();
}

class _UpcomingEventEditScreenState
    extends ConsumerState<UpcomingEventEditScreen> {
  late final upcomingEvent = widget.upcomingEventIndex != -1
      ? ref.read(upcomingEventsProvider)[widget.upcomingEventIndex]
      : UpcomingEventProvider(
          (ref) => UpcomingEventController(UpcomingEventModel.empty()),
        );

  late final editProvider = UpcomingEventProvider((ref) {
    return UpcomingEventController(ref.read(upcomingEvent));
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      ),
      child: UnsavedChangesWrapper(
        upcomingEvent: upcomingEvent,
        editProvider: editProvider,
        child: Scaffold(
          body: _EditSubPageContent(
            upcomingEvent: upcomingEvent,
            editProvider: editProvider,
          ),
          persistentFooterButtons: [
            ActionButtons(
              upcomingEvent: upcomingEvent,
              editProvider: editProvider,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditSubPageContent extends StatefulWidget {
  final UpcomingEventProvider upcomingEvent;
  final UpcomingEventProvider editProvider;

  const _EditSubPageContent({
    required this.upcomingEvent,
    required this.editProvider,
  });

  @override
  State<_EditSubPageContent> createState() => _EditSubPageContentState();
}

class _EditSubPageContentState extends State<_EditSubPageContent> {
  bool _isDetailsExpanded = false;

  late final _editFields = Column(
    children: [
      TypeEdit(editProvider: widget.editProvider),
      NameEdit(editProvider: widget.editProvider),
      DateDaysTimeEdit(editProvider: widget.editProvider),
    ],
  );

  /// Unfocuses all focus node widgets
  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unfocus(context),
      child: Column(
        children: [
          AppBar(
            forceMaterialTransparency: true,
            leading: BackButton(
              onPressed: () {
                if (_isDetailsExpanded) {
                  _unfocus(context);
                } else {
                  Navigator.of(context).maybePop();
                }
              },
            ),
          ),
          ExpandedSection(
            expand: !_isDetailsExpanded,
            noInitialAnimation: true,
            child: _editFields,
          ),
          DetailsEdit(
            editProvider: widget.editProvider,
            onFocusChange: (isFocused) {
              if (_isDetailsExpanded != isFocused) {
                setState(() => _isDetailsExpanded = isFocused);
              }
            },
          )
        ],
      ),
    );
  }
}
