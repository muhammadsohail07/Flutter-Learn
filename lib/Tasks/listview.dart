import 'package:flutter/material.dart';
class listviewexample extends StatelessWidget {
  const listviewexample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List view"),),
      body: Center(
        child: ListView(
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
            Text("Contacts",textAlign: TextAlign.center , style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold
            )),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('John Doe'),
              subtitle: Text('555-555-5555'),
              trailing: Icon(Icons.call),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Jane Doe'),
              subtitle: Text('555-555-5555'),
              trailing: Icon(Icons.call),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('John Smith'),
              subtitle: Text('555-555-5555'),
              trailing: Icon(Icons.call),
            ),

          ],
        ),
      ),
    );
  }
}
