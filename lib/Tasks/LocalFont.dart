import 'package:flutter/material.dart';

class Localfont extends StatelessWidget {
  const Localfont({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Local Font"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Medium",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 33,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.green
              ),
            ),

            Text(
              "Light",
              style: TextStyle(
                fontFamily: 'Roboto',
                  fontSize: 33,
                fontWeight: FontWeight.w300,
                  color: Colors.grey
              ),
            ),

            Text(
              "Black",
              style: TextStyle(
                fontFamily: 'Roboto',
                  fontSize: 33,
                fontWeight: FontWeight.w900,
                  color: Colors.black
              ),
            )
          ],
        ),
      )
    );
  }
}
