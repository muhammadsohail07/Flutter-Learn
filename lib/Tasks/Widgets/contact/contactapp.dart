import 'package:flutter/material.dart';
 import 'package:flutter_series/Tasks/Widgets/contact/modelcontactapp.dart';
import 'package:flutter_series/Tasks/Widgets/contact/datacontact.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Phone')),
        ],
        rows: contacts.map((contact) {
          return DataRow(cells: [
            DataCell(Text(contact.name)),
            DataCell(Text(contact.email)),
            DataCell(Text(contact.phone)),
          ]);
        }).toList(),
      ),
    );
  }
}