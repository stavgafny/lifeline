import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../models/upcoming_event_model.dart';

class UpcomingEvent extends StatelessWidget {
  static const double _dateFontSize = 18.0;
  static const double _nameFontSize = 20.0;

  static const int defaultMinimumSize = 125;

  static double get additionalTextSizes => _dateFontSize + _nameFontSize;

  static Widget addButton(BuildContext context, {required Function onTap}) {
    return Column(
      children: [
        const SizedBox(height: _dateFontSize),
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(),
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
        ),
        const SizedBox(height: _nameFontSize),
      ],
    );
  }

  final UpcomingEventModel model;
  final Function onTap;
  const UpcomingEvent({
    required this.model,
    required this.onTap,
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
          onTap: () => onTap(),
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
