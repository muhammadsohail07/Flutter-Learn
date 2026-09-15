class UserModel {
  final String email;
  final String password;
  final String name;
  final String? profileImage;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.profileImage,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'profileImage' : profileImage,
    };
  }
}