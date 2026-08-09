import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/Widgets/drawerWidget.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Click End Drawer Icon =>>>>')),
      drawer:  MyDrawerWidget(),
      body: const Center(child: Text('Home Screen')),
    );
  }
}