import 'package:flutter/material.dart';
class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: Drawer( //endDrawer
      ),
      appBar: AppBar(
        title: Text('Click End Drawer Icon =>>>>'),
      ),
    );
  }
}
