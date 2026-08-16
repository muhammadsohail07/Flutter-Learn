import 'package:flutter/material.dart';



class MyApps extends StatelessWidget {
  const MyApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Named route se navigate
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Goto SecondScreen'),
        ),
      ),
    );
  }
}

// Step 1: Define a Screen
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigating Back
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Named route se navigate
                Navigator.pushNamed(context, '/third');
              },
              child: const Text("Go to Third Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigating Back
            Navigator.pop(context);
          },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}