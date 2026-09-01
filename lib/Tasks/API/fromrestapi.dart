import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<dynamic> _quoteData = [];
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes Fetch Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:(){},
              child: Text(_isLoading ? 'Loading...' : 'Fetch Quotes'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _quoteData.length,
                itemBuilder: (context, index) {
                  final quote = _quoteData[index];
                  return ListTile(
                    title: Text(quote['text'] ?? ''),
                    subtitle: Text('- ${quote['from'] ?? 'Unknown'}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}