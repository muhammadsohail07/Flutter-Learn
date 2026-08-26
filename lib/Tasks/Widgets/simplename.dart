import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SimpleName extends StatefulWidget {
  const SimpleName({super.key});

  @override
  State<SimpleName> createState() => _SimpleNameState();
}

class _SimpleNameState extends State<SimpleName> {

  // Controller for TextField
  final TextEditingController nameController =
  TextEditingController();

  // Variable to display saved name
  String savedName = "No name saved";


  Future<void> saveName() async {

    // Get SharedPreferences object
    final prefs = await SharedPreferences.getInstance();

    // Get text from TextField
    String name = nameController.text;

    // Save String
    await prefs.setString("username", name);

    // Update UI
    setState(() {
      savedName = name;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Name saved successfully"),
      ),
    );
  }

  // =========================
  // GET DATA
  // =========================

  Future<void> getName() async {

    final prefs = await SharedPreferences.getInstance();

    // Read String
    String? name = prefs.getString("username");

    setState(() {
      savedName = name ?? "No name saved";
    });
  }

  // =========================
  // DELETE DATA
  // =========================

  Future<void> deleteName() async {

    final prefs = await SharedPreferences.getInstance();

    // Remove username
    await prefs.remove("username");

    setState(() {
      savedName = "No name saved";
    });
  }

  @override
  void initState() {
    super.initState();

    // Get saved data when app starts
    getName();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // Display saved name
            Text(
              "Saved Name: $savedName",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Input
            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: "Enter your name",
                hintText: "Example: Sahu",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveName,
                child: const Text("Save"),
              ),
            ),

            // Get button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: getName,
                child: const Text("Get"),
              ),
            ),

            // Delete button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: deleteName,
                child: const Text("Delete"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}