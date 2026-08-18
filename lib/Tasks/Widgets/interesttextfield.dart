import 'package:flutter/material.dart';

Widget interestTextField(
    String labelText, String hintText, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      focusColor: Colors.black45,
      border: OutlineInputBorder(),
    ),
  );
}