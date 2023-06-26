import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: const [
              DrawerHeader(
                child: CircleAvatar(
                  child: Text("\$ProfileImage\$"),
                ),
              ),
              ListTile(
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
