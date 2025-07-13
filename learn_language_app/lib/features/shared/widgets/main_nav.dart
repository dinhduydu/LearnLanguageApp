import 'package:flutter/material.dart';

class MainNav extends StatelessWidget {
  const MainNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 150, 150)),
            child: Text('Learn Language', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Đóng Drawer trước
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.alarm),
            title: const Text('Reminder'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/reminder');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Favourite'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favourite');
            },
          ),
        ],
      ),
    );
  }
}
