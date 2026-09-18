import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_series/Tasks/API/LOGIN/loginmodel.dart';
import 'package:flutter_series/Tasks/API/LOGIN/hashhelper.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String binUrl =
      'https://api.jsonbin.io/v3/b/6a9c4f24f5f4af5e296eca9d';
  static const String apiKey =
      r'$2a$10$e3kbIVIVSzjC/XvLso.qWeTyzULo/f1TEh3/sxuHo67RElU5l3Gbe';

  static const Duration _timeout = Duration(seconds: 15);

  Exception _mapError(Object e) {
    if (e is SocketException) {
      return Exception('No internet connection. Please check your network.');
    }
    if (e is TimeoutException) {
      return Exception('Request timed out. Please try again.');
    }
    if (e is FormatException) {
      return Exception('Unexpected response from server.');
    }
    if (e is Exception) {
      return e;
    }
    return Exception('Something went wrong. Please try again.');
  }

  Future<Map<String, dynamic>> _fetchRecord() async {
    final response = await http
        .get(
      Uri.parse(binUrl),
      headers: {
        'X-Master-Key': apiKey,
        'Content-Type': 'application/json',
      },
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['record'] as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key.');
    } else if (response.statusCode == 404) {
      throw Exception('Data not found.');
    } else {
      throw Exception('Server error (${response.statusCode}). Try again later.');
    }
  }

  Future<void> _saveUsers(List<dynamic> usersList) async {
    final response = await http
        .put(
      Uri.parse(binUrl),
      headers: {
        'X-Master-Key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'users': usersList}),
    )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('Server error (${response.statusCode}). Try again later.');
    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final record = await _fetchRecord();
      final usersList = record['users'] as List<dynamic>;

      final hashedInput = HashHelper.hashPassword(password);

      for (var userJson in usersList) {
        final user = UserModel.fromJson(userJson);
        if (user.email == email && user.password == hashedInput) {
          return user;
        }
      }
      return null;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<bool> signup(String email, String password, String name) async {
    try {
      final record = await _fetchRecord();
      final usersList = List<dynamic>.from(record['users'] as List<dynamic>);

      final alreadyExists = usersList.any((u) => u['email'] == email);
      if (alreadyExists) {
        throw Exception('Email already registered');
      }

      usersList.add({
        'email': email,
        'password': HashHelper.hashPassword(password),
        'name': name,
      });

      await _saveUsers(usersList);
      return true;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final record = await _fetchRecord();
      final usersList = List<dynamic>.from(record['users'] as List<dynamic>);

      final index = usersList.indexWhere((u) => u['email'] == email);
      if (index == -1) {
        throw Exception('Email not found');
      }

      usersList[index]['password'] = HashHelper.hashPassword(newPassword);

      await _saveUsers(usersList);
      return true;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserModel> updateProfile(
      String email,
      String newName,
      String newPassword,
      ) async {
    try {
      final record = await _fetchRecord();
      final usersList = List<dynamic>.from(record['users'] as List<dynamic>);

      final index = usersList.indexWhere((u) => u['email'] == email);
      if (index == -1) {
        throw Exception('User not found');
      }

      usersList[index]['name'] = newName;
      usersList[index]['password'] = HashHelper.hashPassword(newPassword);

      await _saveUsers(usersList);
      return UserModel.fromJson(usersList[index]);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> updateProfileImage(String email, String imageUrl) async {
    try {
      final record = await _fetchRecord();
      final usersList = List<dynamic>.from(record['users'] as List<dynamic>);

      final index = usersList.indexWhere((u) => u['email'] == email);
      if (index == -1) {
        throw Exception('User not found');
      }

      usersList[index]['profileImage'] = imageUrl;

      await _saveUsers(usersList);
    } catch (e) {
      throw _mapError(e);
    }
  }
}