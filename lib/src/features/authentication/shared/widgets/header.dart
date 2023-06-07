import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final String info;
  const Header({
    super.key,
    required this.info,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.75,
          child: Image.asset(
            "assets/logo_outline.png",
            fit: BoxFit.contain,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(title, style: GoogleFonts.pacifico(fontSize: 42.0)),
        Text(info),
      ],
    );
  }
}
