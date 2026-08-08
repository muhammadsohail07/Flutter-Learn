import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/Quote App/servicequoteapp.dart';
import 'package:flutter_series/Tasks/Quote App/quotewidget.dart';
import 'package:flutter_series/Tasks/Quote App/modelquoteapp.dart';

class Quoteapp extends StatefulWidget {
  const Quoteapp({super.key});

  @override
  State<Quoteapp> createState() => _QuoteappState();
}

class _QuoteappState extends State<Quoteapp> {
  late Future<List<Quote>> futureQuotes;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureQuotes = ServiceQuoteApp().getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Daily Quotes'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF6A11CB),
      ),
      body: FutureBuilder<List<Quote>>(
        future: futureQuotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final quotes = snapshot.data!;

            if (quotes.isEmpty) {
              return const Center(child: Text('No quotes found'));
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: QuoteWidget(quote: quotes[currentIndex]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex + 1) % quotes.length;
                      });
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Next Quote'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A11CB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}