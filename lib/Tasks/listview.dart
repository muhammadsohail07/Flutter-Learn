import 'package:flutter/material.dart';
class listviewexample extends StatelessWidget {
  const listviewexample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Go to Gym'),
            subtitle: Text('Go to Gym at 6:00 AM'),
          ),
          ListTile(
            title: Text('Go to College'),
            subtitle: Text('Go to College at 8:00 AM'),
          ),
          ListTile(
            title: Text('Go to Office'),
            subtitle: Text('Go to Office at 11:00 AM'),
          ),

        ],
      ),
    );
  }
}
