import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class crud extends StatefulWidget {
  const crud({super.key});

  @override
  State<crud> createState() => _crudState();
}

class _crudState extends State<crud> {
  final nameController = TextEditingController();
  String savedname = "no name saved";

  Future<void> savedName() async{
   final prefs =  await SharedPreferences.getInstance();
   String name = nameController.text;

   await prefs.setString("username", name);
   setState(() {
     savedname = name;
   });
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Text("name saved successfully"),
   ));
  }

  Future<void> getnamed() async{
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("username");
    setState(() {
      savedname = name?? "no name saved";
    });
  }

  Future<void> deletenamed() async  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    setState(() {

      savedname = "no name save";
    });
  }

  @override
 void initState(){
    super.initState();
    getnamed();
  }
  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("crud"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("saved name: $savedName()",
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
            child: ElevatedButton(onPressed: savedName, child: Text("Saved")),
          ),
          SizedBox(height: 22,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: getnamed, child: Text("Get")),
          ),
          SizedBox(height: 22,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: deletenamed, child: Text("Delete")),
          ),
        ],
      ),
    );
  }
}
