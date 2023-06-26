import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/router/providers/guards/auth_state_provider.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              DrawerHeader(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(user.photoURL ?? ""),
                  ),
                ),
              ),
              const ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: ListTile(
              title: Text("Toggle Theme"),
              leading: Icon(Icons.color_lens_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
