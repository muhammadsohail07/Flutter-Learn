import 'package:flutter/material.dart';

class EnterNameScreen extends StatelessWidget {

  final TextEditingController _text = TextEditingController();
  EnterNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Greeting"),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextField(
                   controller: _text,
                   decoration: InputDecoration(
                     labelText: 'Name',
                     hintText: 'Enter your name',
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                     ),
                     filled: true,
                     fillColor: Colors.grey.shade100,
                     prefixIcon: const Icon(Icons.person_outline),
                   ),

                 )
                 ,
                 ElevatedButton(
                   onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ShowScreen(name: _text.text)));
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.green,
                     foregroundColor: Colors.white,
                     minimumSize: const Size(double.infinity, 50),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                   child: const Text(
                     'Submit',
                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                   ),
                 )
               ],
             ),
          ),
        ),
      ),
    );
  }
}

class ShowScreen extends StatelessWidget {
  String name;
 ShowScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
    );
  }
}
