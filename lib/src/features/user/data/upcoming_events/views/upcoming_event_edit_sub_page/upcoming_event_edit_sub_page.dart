import 'package:flutter/material.dart';
import '../../models/upcoming_event_model.dart';
import './widgets/type_edit.dart';
import './widgets/name_edit.dart';
import './widgets/date_days_time_edit.dart';
import './widgets/details_edit.dart';
import './widgets/action_buttons.dart';

class UpcomingEventEditSubPage extends StatelessWidget {
  final UpcomingEventModel model;

  const UpcomingEventEditSubPage({super.key, required this.model});

  static void display(BuildContext context, UpcomingEventModel model) {
    showDialog(
      context: context,
      builder: (context) => UpcomingEventEditSubPage(model: model),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

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
              TypeEdit(model: model),
              NameEdit(model: model),
              DateDaysTimeEdit(model: model),
              DetailsEdit.preview(
                text: "asd",
                onTap: () {
                  DetailsEdit.displayEditPage(
                    context,
                    title: model.name,
                    text: "abc",
                  );
                },
              ),
              const ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
