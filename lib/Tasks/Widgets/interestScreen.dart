import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/Widgets/interesttextfield.dart';

class interestScreen extends StatefulWidget {
   interestScreen({super.key});
  final principle = TextEditingController();
   final rate = TextEditingController();
   final time = TextEditingController();
   final result = "";
  @override
  State<interestScreen> createState() => _interestScreenState();
}



class _interestScreenState extends State<interestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
