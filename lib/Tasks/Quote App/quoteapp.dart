import 'dart:convert';

import 'package:flutter_series/Tasks/Quote%20App/modelquoteapp.dart';
 class ServiceQuoteApp{
   Future<List<quote>> getQuotes async{
     final response = await;
   http.get(Uri.parse("https://api.jsonbin.io/v3/b/6a74c9b3f5f4af5e29f3e532"));
   final json = jsonDecode(response.body).cast<Map< String, dynamic>>();
   return json.map<quote>((json)=>quote.fromJson(json)).toList();
 }
 }
