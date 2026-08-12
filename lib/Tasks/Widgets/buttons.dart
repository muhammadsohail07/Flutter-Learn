import 'package:flutter/material.dart';

class materialButton extends StatelessWidget {
  const materialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("material button"),
      ),
    body: MaterialButton(
      onPressed: () {},
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: const Text('Press Me'),
    ),);
  }
}
