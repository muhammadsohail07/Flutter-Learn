import 'package:flutter/material.dart';

class StackDetails extends StatelessWidget {
  const StackDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack')),
      body: Center(
        child: Stack(
          children: [
            Image.network(
              'https://images.pexels.com/photos/19060954/pexels-photo-19060954/free-photo-of-iphone-15-pro-max.jpeg',
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'iPhone 15 Pro Max',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}