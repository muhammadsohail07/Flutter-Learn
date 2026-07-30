import 'package:flutter/material.dart';
class Profileui extends StatelessWidget {
  const Profileui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSzec9r0soK0NBW83ZuKTqqJyY9b6TLCSGChXcEkOWgw&s=10",
              ),
            ),
            Column(
              children: [
                Text("Muhammad Sohail", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
