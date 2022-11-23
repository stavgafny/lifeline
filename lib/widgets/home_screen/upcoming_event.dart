import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/upcoming_event_model.dart';

class UpcomingEvent extends StatelessWidget {
  static Widget addButton(BuildContext context) {
    return Container(
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
    );
  }

  final UpcomingEventModel model;

  const UpcomingEvent({
    required this.model,
    Key? key,
  }) : super(key: key);

  Widget _buildDate(BuildContext context) {
    return const Text(
      "12/1/2001",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10.0,
      ),
    );
  }

  Widget _buildBlob(BuildContext context) {
    return Flexible(
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
          child: Transform.scale(
            scale: .75,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "13",
                textAlign: TextAlign.center,
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

  Widget _buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        model.name,
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textWidthBasis: TextWidthBasis.longestLine,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildDate(context),
          _buildBlob(context),
          _buildName(context),
        ],
      ),
    );
  }
}
