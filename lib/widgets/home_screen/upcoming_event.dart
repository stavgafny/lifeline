// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/upcoming_event_model.dart';

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
  const UpcomingEvent({
    required this.model,
    Key? key,
  }) : super(key: key);

  Widget _buildDate(BuildContext context) {
    return const SizedBox(
      height: _dateFontSize,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          "12/1/2001",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
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

  Widget _buildBlob(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
              child: Text(
                "13",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDate(context),
        _buildBlob(context),
        _buildName(context),
      ],
    );
  }
}
