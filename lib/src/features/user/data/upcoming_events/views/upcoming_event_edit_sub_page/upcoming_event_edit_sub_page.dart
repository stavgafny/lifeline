import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/expanded_section.dart';
import '../../controllers/upcoming_event_controller.dart';
import './widgets/type_edit.dart';
import './widgets/name_edit.dart';
import './widgets/date_days_time_edit.dart';
import './widgets/details_edit.dart';
import './widgets/action_buttons.dart';

class UpcomingEventEditSubPage extends StatelessWidget {
  static void display(
    BuildContext context, {
    required UpcomingEventProvider upcomingEvent,
    required final void Function() onDelete,
  }) {
    final editPage = UpcomingEventEditSubPage._(
      upcomingEvent: upcomingEvent,
      editProvider: UpcomingEventProvider((ref) {
        return UpcomingEventController(ref.read(upcomingEvent));
      }),
      onDelete: onDelete,
    );

    showDialog(
      context: context,
      builder: (context) => editPage,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final UpcomingEventProvider upcomingEvent;
  final UpcomingEventProvider editProvider;
  final void Function() onDelete;

  const UpcomingEventEditSubPage._({
    required this.upcomingEvent,
    required this.editProvider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(forceMaterialTransparency: true),
        body: _EditSubPageContent(
          upcomingEvent: upcomingEvent,
          editProvider: editProvider,
        ),
        persistentFooterButtons: [
          ActionButtons(
            upcomingEvent: upcomingEvent,
            editProvider: editProvider,
            onDelete: onDelete,
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandedSection(
          expand: !_isDetailsExpanded,
          noInitialAnimation: true,
          child: Column(
            children: [
              TypeEdit(editProvider: widget.editProvider),
              NameEdit(editProvider: widget.editProvider),
              DateDaysTimeEdit(editProvider: widget.editProvider),
            ],
          ),
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
    );
  }
}
