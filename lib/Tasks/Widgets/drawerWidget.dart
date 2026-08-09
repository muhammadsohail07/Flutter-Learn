import 'package:flutter/material.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(   // <-- Scaffold nahi, seedha Drawer return karo
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(title: const Text('Home'), onTap: () {}),
          ListTile(title: const Text('Categories'), onTap: () {}),
          ListTile(title: const Text('Orders'), onTap: () {}),
          ListTile(title: const Text('Wishlist'), onTap: () {}),
          ListTile(title: const Text('Settings'), onTap: () {}),
        ],
      ),
    );
  }
}