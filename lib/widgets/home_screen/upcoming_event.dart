import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/upcoming_event_model.dart';
import '../../controllers/upcoming_event_controller.dart';
import '../../widgets/wheel_input.dart';

class UpcomingEvent extends StatelessWidget {
  static const double _dateFontSize = 14.0;
  static const double _nameFontSize = 20.0;

  static const int defaultMinimumSize = 125;

  static double get additionalTextSizes => _dateFontSize + _nameFontSize;

  static Widget addButton(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: _dateFontSize),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: Transform.scale(
              scale: .5,
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: _nameFontSize),
      ],
    );
  }

  final UpcomingEventModel model;
  final Function onChange;
  final Function onDelete;
  const UpcomingEvent({
    required this.model,
    required this.onChange,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  Widget _date(BuildContext context) {
    return SizedBox(
      height: _dateFontSize,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          model.stringifiedDateDDMMYYYY(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _type(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => _ExtendedUpcomingEvent(
                model: model,
                onChange: onChange,
                onDelete: onDelete,
              ),
            ),
          ),
          //! Hero this container to expended (upcoming event type transition)
          child: Hero(
            tag: model,
            transitionOnUserGestures: true,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: model.type.value,
                  opacity: .65,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FittedBox(
                  fit: BoxFit.contain,
                  //! Default empty text style instance for the hero transition between the scaffolds
                  child: DefaultTextStyle(
                    style: const TextStyle(),
                    child: Transform.scale(
                      scale: .8,
                      child: Text(
                        model.daysRemain().toString(),
                        textAlign: TextAlign.center,
                        textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent: true,
                          applyHeightToLastDescent: false,
                        ),
                        style: GoogleFonts.pacifico(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Center(
      child: Text(
        model.name,
        style: const TextStyle(
          fontSize: _nameFontSize,
          height: 1.0,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _date(context),
        _type(context),
        _name(context),
      ],
    );
  }
}

class _ExtendedUpcomingEvent extends StatefulWidget {
  final UpcomingEventModel model;
  final Function onChange;
  final Function onDelete;
  const _ExtendedUpcomingEvent({
    required this.model,
    required this.onChange,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<_ExtendedUpcomingEvent> createState() => _ExtendedUpcomingEventState();
}

class _ExtendedUpcomingEventState extends State<_ExtendedUpcomingEvent> {
  // Setting a controller on editable fields when widget is initialized
  late final _controller = UpcomingEventController(model: widget.model);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeDate() async {
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
      _controller.setNewDate(newDate);
      setState(() {});
    }
  }

  void _changeDays() {
    final daysRemain = _controller.editableModel.daysRemain();
    showDialog(
      context: context,
      builder: (context) => WheelInputDaysDialog(
        days: daysRemain <= 0 ? 1 : daysRemain,
        onSubmit: (days) {
          _controller.setNewDays(days);
          setState(() {});
        },
        range: UpcomingEventModel.dateRange + 1,
      ),
    );
  }

  Widget _type(BuildContext context) {
    //! Hero this container to folded (upcoming event type transition)
    return Hero(
      tag: widget.model,
      transitionOnUserGestures: true,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: widget.model.type.value,
            ),
          ),
          child: Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {},
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

  Widget _date(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: MaterialButton(
          onPressed: _changeDate,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text("Date"),
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      _controller.editableModel.stringifiedDateDDMONRR(),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      _controller.editableModel.dateDayOfWeek(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _days(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: MaterialButton(
          onPressed: _changeDays,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text("Days"),
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      _controller.editableModel.daysRemain().toString(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateDaysButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 50.0),
      child: Row(
        children: [
          _date(context),
          _days(context),
        ],
      ),
    );
  }

  Widget _delete(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: MaterialButton(
        onPressed: () => widget.onDelete(),
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
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 50.0),
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
    return GestureDetector(
      //! If focused on textfield and touched anywhere else then unfocus
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(automaticallyImplyLeading: false),
        ),
        //! Material ancestor to the widgets below (transperent)
        body: Material(
          type: MaterialType.transparency,
          child: Column(
            children: [
              _type(context),
              _name(context),
              Expanded(child: _dateDaysButtons(context)),
              _deleteApplyButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
