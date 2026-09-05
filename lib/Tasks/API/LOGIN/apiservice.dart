import 'package:flutter_series/Tasks/API/LOGIN/loginmodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {
  static const String binUrl = 'https://api.jsonbin.io/v3/b/6a9c4f24f5f4af5e296eca9d';
  static const String apiKey = r'$2a$10$e3kbIVIVSzjC/XvLso.qWeTyzULo/f1TEh3/sxuHo67RElU5l3Gbe';




   Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.get(
        Uri.parse(binUrl),
        headers: {
          'X-Master-Key': apiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final record = data['record'];
        final usersList = record['users'] as List<dynamic>;

        for (var userJson in usersList) {
          final user = UserModel.fromJson(userJson);
          if (user.email == email && user.password == password) {
            return user;
          }
        }
        return null;
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}
