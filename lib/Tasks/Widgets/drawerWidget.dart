import 'package:flutter/material.dart';
import 'package:flutter_series/main.dart';
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
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            subtitle: Text('Go to homepage'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(title: const Text('Categories'), onTap: () {}),
          ListTile(title: const Text('Orders'), onTap: () {}),
          ListTile(title: const Text('Wishlist'), onTap: () {}),
          ListTile(title: const Text('Settings'), onTap: () {}),
        ],
      ),
    );
  }
}