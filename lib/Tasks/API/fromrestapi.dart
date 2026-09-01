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

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://api.jsonbin.io/v3/b/6a9717aada38895dfe2c3390'),
      );
      if (response.statusCode == 200) {

        final decoded = jsonDecode(response.body);
        setState(() {
          _quoteData = decoded['record'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
              onPressed: _isLoading ? null : fetchData,
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