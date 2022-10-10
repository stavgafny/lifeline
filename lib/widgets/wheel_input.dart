import 'package:flutter/material.dart';

class WheelInputController {
  final FixedExtentScrollController _controller;
  final int range;
  WheelInputController? mount;

  int _current;

  WheelInputController({required this.range, int initialValue = 0, this.mount})
      : _controller = FixedExtentScrollController(initialItem: initialValue),
        _current = initialValue;

  int get selected => _controller.hasClients
      ? getReletive(_controller.selectedItem)
      : _controller.initialItem;

  bool get modified =>
      _controller.hasClients &&
      getReletive(_controller.selectedItem) != _controller.initialItem;

  int getReletive(int value) => value % range;

  void reset() {
    // temporarily removes potential mount to not affect when resetting
    final WheelInputController? temp = mount;
    mount = null;
    _controller.jumpToItem(_controller.initialItem);
    mount = temp;
  }

  void modify(bool v) {
    if (!_controller.hasClients) return;
    _controller.animateToItem(
      _controller.selectedItem + (v ? 1 : -1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void update(int value) {
    if (value ~/ range != _current ~/ range) {
      mount?.modify(value ~/ range > _current ~/ range);
    } else if (value < 0 && _current >= 0 || value >= 0 && _current < 0) {
      mount?.modify(value > _current);
    }
    _current = value;
  }

  void dispose() {
    _controller.dispose();
  }
}

class WheelInput extends StatefulWidget {
  final WheelInputController controller;
  final String? name;
  final bool resetable;
  final bool leadingZero;

  const WheelInput({
    required this.controller,
    this.name,
    this.resetable = false,
    this.leadingZero = false,
    Key? key,
  }) : super(key: key);

  @override
  State<WheelInput> createState() => _WheelInputState();
}

class _WheelInputState extends State<WheelInput> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  String _getSelected(int value) => widget.controller
      .getReletive(value)
      .toString()
      .padLeft(widget.leadingZero ? 2 : 1, '0');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildName(),
        _buildWheel(),
        _buildReset(),
      ],
    );
  }

  Widget _buildName() {
    if (widget.name != null) {
      return Column(
        children: [
          Text(widget.name!),
          const SizedBox(height: 6),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildWheel() {
    return SizedBox(
      width: 60,
      height: 80,
      child: ListWheelScrollView.useDelegate(
        controller: widget.controller._controller,
        onSelectedItemChanged: (index) =>
            setState(() => widget.controller.update(index)),
        itemExtent: 30,
        useMagnifier: true,
        magnification: 1.5,
        diameterRatio: 1.25,
        overAndUnderCenterOpacity: .5,
        physics: const FixedExtentScrollPhysics(),
        squeeze: 1,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => Center(
            child: Text(_getSelected(index)),
          ),
        ),
      ),
    );
  }

  Widget _buildReset() {
    if (widget.resetable) {
      return Column(
        children: [
          IconButton(
            onPressed:
                widget.controller.modified ? widget.controller.reset : null,
            icon: const Icon(Icons.restore),
            style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

class WheelInputDurationDialog extends StatelessWidget {
  final int days;
  final int hours;
  final int minutes;
  final Function(int, int, int) onSubmit;

  const WheelInputDurationDialog({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayController = WheelInputController(
      range: 365,
      initialValue: days,
    );
    final hourController = WheelInputController(
      range: 24,
      initialValue: hours,
      mount: dayController,
    );
    final minuteController = WheelInputController(
      range: 60,
      initialValue: minutes,
      mount: hourController,
    );

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: 220,
        height: 220,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WheelInput(
                  controller: dayController,
                  name: "Day",
                  resetable: true,
                  leadingZero: true,
                ),
                WheelInput(
                  controller: hourController,
                  name: "Hour",
                  resetable: true,
                  leadingZero: true,
                ),
                WheelInput(
                  controller: minuteController,
                  name: "Minute",
                  resetable: true,
                  leadingZero: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 80),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onSubmit(
                      dayController.selected,
                      hourController.selected,
                      minuteController.selected,
                    );
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text("Ok"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
