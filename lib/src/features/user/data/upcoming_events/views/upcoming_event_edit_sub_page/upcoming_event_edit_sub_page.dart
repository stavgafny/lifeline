import 'package:flutter/material.dart';
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

  /// Unfocuses all focus node widgets
  void _unfocus(BuildContext context) => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () => _unfocus(context),
          child: Column(
            children: [
              TypeEdit(editProvider: editProvider),
              NameEdit(editProvider: editProvider),
              DateDaysTimeEdit(editProvider: editProvider),
              DetailsEdit.preview(
                text: "123",
                onTap: () {
                  DetailsEdit.displayEditPage(
                    context,
                    title: "name",
                    text: "321",
                  );
                },
              ),
              ActionButtons(
                upcomingEvent: upcomingEvent,
                editProvider: editProvider,
                onDelete: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
