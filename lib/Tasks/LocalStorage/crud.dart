import 'package:flutter/material.dart';

class crud extends StatefulWidget {
  const crud({super.key});

  @override
  State<crud> createState() => _crudState();
}

class _crudState extends State<crud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("crud"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("saved name",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 22,),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Enter name",
              hintText: "example sohail",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 22,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: , child: Text("Saved")),
          ),
          SizedBox(height: 22,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: , child: Text("Get")),
          ),
          SizedBox(height: 22,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: , child: Text("Delete")),
          ),
        ],
      ),
    );
  }
}
