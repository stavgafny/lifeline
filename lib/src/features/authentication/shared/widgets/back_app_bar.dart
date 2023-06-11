import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () => context.go(AppRoutes.signin),
        icon: const Icon(Icons.arrow_back),
      ),
      forceMaterialTransparency: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
