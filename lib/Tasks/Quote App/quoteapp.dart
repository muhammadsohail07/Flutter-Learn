import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/Quote App/servicequoteapp.dart';
import 'package:flutter_series/Tasks/Quote App/quotewidget.dart';
import 'package:flutter_series/Tasks/Quote App/modelquoteapp.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: const Text('Daily Quotes'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF6A11CB),
        ),
        body: FutureBuilder<List<quote>>(
          future: ServiceQuoteApp().getQuotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              final quotes = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return QuoteWidget(quote: quotes[index]);
                },
              );
            }
            return const Center(child: Text('No data available'));
          },

      ),
    );
  }
}