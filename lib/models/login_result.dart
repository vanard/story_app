import 'dart:convert';

class LoginResponse {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });
}

class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult({required this.userId, required this.name, required this.token});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'name': name, 'token': token};
  }

  factory LoginResult.fromMap(Map<String, dynamic> map) {
    return LoginResult(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResult.fromJson(String source) =>
      LoginResult.fromMap(json.decode(source));
}
