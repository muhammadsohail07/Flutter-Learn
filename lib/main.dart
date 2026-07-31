import 'package:flutter/material.dart';
import 'task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Flutter Practice')),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(

              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                hoverColor: Colors.green ,
                title: Text(task.title),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => task.page),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}