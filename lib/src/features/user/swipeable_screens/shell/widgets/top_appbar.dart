import 'package:flutter/material.dart';

class TopAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Theme.of(context).appBarTheme.backgroundColor!,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
      ),
    );
  }
}
