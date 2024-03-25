import 'package:flutter/material.dart';

class TimelineAddEntryButton extends StatelessWidget {
  static const double height = 120.0;

  static const _margin = EdgeInsets.symmetric(horizontal: 4.0);
  static const _borderRadius = BorderRadius.all(Radius.circular(12.0));
  static const _textStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  final int entryNumber;
  final void Function() onTap;

  const TimelineAddEntryButton({
    super.key,
    required this.entryNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margin,
      child: SizedBox.expand(
        child: MaterialButton(
          color: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: _borderRadius,
          ),
          onPressed: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.format_list_bulleted_add, size: 60.0),
              Text("Add #$entryNumber entry", style: _textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
