import 'package:flutter/material.dart';

class materialButton extends StatelessWidget {
  const materialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("material button"),
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {},
            color: Colors.blue,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: const Text('Press Me'),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: Text('Rounded Corners'),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: Icon(Icons.phone),
          ),
          SizedBox(height: 10,),
          Text("MINI FAB"),
          FloatingActionButton(
            mini: true,
            onPressed: () {},
            child: Icon(Icons.star),
          ),
          SizedBox(height: 10,),
          FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Add Item'),
          ),
          SizedBox(height: 10,),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
            tooltip: 'More Info',
          ),
          SizedBox(height: 10,),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: Text('Rounded Corners'),
          )
          ,
          SizedBox(height: 10,),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.yellow,
            ),
            child: Text('Custom Style'),
          )
        ],
      ),
    ),);
  }
}
