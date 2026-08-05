import 'package:flutter/material.dart';
import 'servicelocaljson.dart';
import 'modellocaljson.dart';
import 'dart:io';

class Localjson extends StatelessWidget {
  const Localjson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   Scaffold(
        appBar: AppBar(
          title: const Text("Local JSON"),
        ),
        body: FutureBuilder(

          future: LocalService().loadPerson(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              Person person = snapshot.data as Person;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: ClipOval(
                              child: Image.asset(
                                person.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person, size: 50);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Text(

                            person.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            person.address,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Age: ${person.age}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            person.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),

    );
  }
}