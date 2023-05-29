import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../models/upcoming_event_model.dart';
import '../../../../../controllers/upcoming_event_controller.dart';
import '../../../../../widgets/wheel_input.dart';

const _dateContainer = Color(0xFF3C2B37);
const _daysContainer = Color(0xFF523547);
const _timeContainer = Color(0xFF9B608A);

class EditableUpcomingEventPage extends StatefulWidget {
  static const _dateDaysTimeEditHeight = 100.0;

  final UpcomingEventModel model;
  final Function onChange;
  final Function onDelete;
  const EditableUpcomingEventPage({
    required this.model,
    required this.onChange,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<EditableUpcomingEventPage> createState() =>
      _EditableUpcomingEventPageState();
}

class _EditableUpcomingEventPageState extends State<EditableUpcomingEventPage> {
  // Setting a controller on editable fields when widget is initialized
  late final _controller = UpcomingEventController(model: widget.model);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Unfocuses all focus node widgets
  void _unfocus() => FocusScope.of(context).unfocus();

  void _changeType() {
    _unfocus();
    showDialog(
      context: context,
      builder: (context) => _UpcomingEventTypeEditDialog(
        onSubmit: (UpcomingEventType type) {
          Navigator.of(context, rootNavigator: true).pop();
          _controller.setType(type);
          setState(() {});
        },
      ),
    );
  }

  void _changeDate() async {
    _unfocus();
    final now = DateTime.now();
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: now.isAfter(_controller.editableModel.date)
          ? now
          : _controller.editableModel.date,
      firstDate: now,
      lastDate: now.add(const Duration(days: UpcomingEventModel.dateRange)),
    );
    if (newDate != null) {
      _controller.setDate(newDate);
      setState(() {});
    }
  }

  void _changeDays() {
    _unfocus();
    final daysRemain = _controller.editableModel.daysRemain();
    showDialog(
      context: context,
      builder: (context) => WheelInputDaysDialog(
        days: daysRemain.isNegative ? 0 : daysRemain,
        onSubmit: (int days) {
          _controller.setDays(days);
          setState(() {});
        },
        range: UpcomingEventModel.dateRange + 1,
      ),
    );
  }

  void _changeTime() async {
    _unfocus();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_controller.editableModel.date),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (time != null) {
      _controller.setTime(time);
      setState(() {});
    }
  }

  Widget _type(BuildContext context) {
    //! Hero this container to folded (upcoming event type transition)
    return AspectRatio(
      aspectRatio: 1.5,
      child: Hero(
        tag: widget.model,
        transitionOnUserGestures: true,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: _controller.editableModel.type.value,
            ),
          ),
          child: Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: _changeType,
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: _controller.nameController,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 26.0),
        decoration: const InputDecoration(
          labelText: "Name",
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.all(6.0),
        ),
      ),
    );
  }

  Widget _fittedText(String text) {
    return Expanded(
      child: SizedBox(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(text),
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    return MaterialButton(
      height: double.infinity,
      onPressed: _changeDate,
      color: _dateContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Date"),
          const SizedBox(height: 10.0),
          _fittedText(_controller.editableModel.stringifiedDateDDMONRR()),
          const SizedBox(height: 10.0),
          _fittedText(_controller.editableModel.dateDayOfWeek()),
        ],
      ),
    );
  }

  Widget _days(BuildContext context) {
    return MaterialButton(
      height: double.infinity,
      onPressed: _changeDays,
      color: _daysContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Days"),
          _fittedText(_controller.editableModel.daysRemain().toString()),
        ],
      ),
    );
  }

  Widget _time(BuildContext context) {
    return MaterialButton(
      height: double.infinity,
      onPressed: _changeTime,
      color: _timeContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Time"),
          _fittedText(_controller.editableModel.timeOfDay()),
        ],
      ),
    );
  }

  Widget _dateDaysTimeButtons(BuildContext context) {
    return SizedBox(
      height: EditableUpcomingEventPage._dateDaysTimeEditHeight,
      child: Row(
        children: [
          Expanded(flex: 5, child: _date(context)),
          Expanded(flex: 3, child: _days(context)),
          Expanded(flex: 3, child: _time(context)),
        ],
      ),
    );
  }

  Widget _details(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _unfocus();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  _DetailsEditPage(_controller.detailsController),
            ),
          );
        },
        child: _DetailsTextField(
          controller: _controller.detailsController,
          enabled: false,
        ),
      ),
    );
  }

  Widget _delete(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          widget.onDelete();
        },
        color: Colors.red,
        padding: EdgeInsets.zero,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Transform.scale(
            scale: .8,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                Icons.delete_forever,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _apply(BuildContext context) {
    return Obx(
      () => MaterialButton(
        onPressed: _controller.edited.value
            ? () {
                _controller.saveChanges();
                widget.onChange();
              }
            : null,
        height: double.infinity,
        elevation: 10.0,
        color: Theme.of(context).colorScheme.primary.withAlpha(200),
        disabledColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Text(
            "Apply",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      ),
    );
  }

  Widget _deleteApplyButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 55.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _delete(context),
            _apply(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(automaticallyImplyLeading: false),
      ),
      body: GestureDetector(
        //! If focused on textfield and touched anywhere else then unfocus
        onTap: _unfocus,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _type(context),
            _name(context),
            _dateDaysTimeButtons(context),
            _details(context),
            _deleteApplyButtons(context),
          ],
        ),
      ),
    );
  }
}

class _UpcomingEventTypeEditDialog extends StatelessWidget {
  final Function(UpcomingEventType type) onSubmit;

  const _UpcomingEventTypeEditDialog({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  Widget _buildType(BuildContext context, UpcomingEventType type) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onSubmit.call(type),
            customBorder: const CircleBorder(),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: type.value,
                  opacity: 1.0,
                ),
              ),
            ),
          ),
        ),
        Text(
          type.name,
          style: const TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }

  Widget _buildTypesGrid(BuildContext context) {
    final upcomingEventsTypes = UpcomingEventType.values.toList();
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 2.0,
      shrinkWrap: true,
      children: List.generate(upcomingEventsTypes.length, (index) {
        return _buildType(context, upcomingEventsTypes[index]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: _buildTypesGrid(context),
      ),
    );
  }
}

class _DetailsTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const _DetailsTextField({required this.controller, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            maxLines: null,
            style: TextStyle(
              fontSize: 18.0,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            decoration:
                const InputDecoration.collapsed(hintText: "Event details"),
            controller: controller,
            enabled: enabled,
            autofocus: enabled,
          ),
        ),
      ),
    );
  }
}

class _DetailsEditPage extends StatelessWidget {
  final TextEditingController controller;
  const _DetailsEditPage(this.controller);

  @override
  Widget build(BuildContext context) {
    // Ensures controller modification happens after setState & Obx changes
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.selection =
            TextSelection.collapsed(offset: controller.text.length);
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: _DetailsTextField(controller: controller, enabled: true),
    );
  }
}
