import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Widget interestTextField(labelText, hintText, controller)
    {
    return TextField(
      decoration: InputDecoration(
        label: labelText ,
        hint: hintText,
        focusColor: Colors.black45
      ),
      controller: controller,
    );
    }