import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/Widgets/interesttextfield.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final TextEditingController principle = TextEditingController();
  final TextEditingController rate = TextEditingController();
  final TextEditingController time = TextEditingController();

  String result = "";

  void interestRateCalculate() {
    double p = double.tryParse(principle.text) ?? 0.0;
    double r = double.tryParse(rate.text) ?? 0.0;
    double t = double.tryParse(time.text) ?? 0.0;

    double interest = p * r * t / 100;

    setState(() {
      result = "Interest: $interest";
    });
  }

  @override
  void dispose() {
    principle.dispose();
    rate.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interest App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            interestTextField("Principle", "Enter principle amount", principle),
            const SizedBox(height: 12),
            interestTextField("Rate", "Enter interest rate", rate),
            const SizedBox(height: 12),
            interestTextField("Time", "Enter time in years", time),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: interestRateCalculate,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}