class ApiService {
  // Apna JSONBin URL yahan lagao, e.g. https://api.jsonbin.io/v3/b/xxxxxxxx
  static const String binUrl = 'YOUR_JSONBIN_URL';

  // Apni JSONBin X-Master-Key yahan lagao
  static const String apiKey = 'YOUR_API_KEY';

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

        // JSONBin response mein actual data "record" ke andar hota hai
        final user = UserModel.fromJson(data['record']);

        if (user.email == email && user.password == password) {
          return user;
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
