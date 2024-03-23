import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/upcoming_event_controller.dart';

class EventType extends ConsumerWidget {
  static const double _imageOpacity = .65;

  final UpcomingEventProvider provider;

  final void Function()? onTap;

  const EventType({super.key, required this.provider, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(provider);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: provider,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: model.type.value,
                  opacity: _imageOpacity,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Transform.translate(
                      // Fix google fonts 'pacifico' relative line height offset
                      offset: const Offset(0, -2),
                      child: Text(
                        model.daysRemain.toString(),
                        textAlign: TextAlign.center,
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
}
