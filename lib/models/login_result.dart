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
}
