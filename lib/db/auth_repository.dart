import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/api_service.dart';
import 'package:story_app/models/login_result.dart';
import 'package:story_app/models/response.dart';

class AuthRepository {
  final String authKey = 'auth';
  final String loginUserKey = 'loginUser';

  late final ApiService _apiService;

  AuthRepository({required ApiService service}) : _apiService = service;

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(authKey) ?? false;
  }

  Future<bool> login(String email, String pass) async {
    final result = await _apiService.loginUser(email, pass);
    debugPrint('Login result: $result');
    // TODO mapper
    final resData = LoginResponse.fromMap(result);
    await saveLoginUser(resData.loginResult);

    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(authKey, true);
  }

  Future<bool> logout() async {
    debugPrint('Logout');
    final preferences = await SharedPreferences.getInstance();

    final loginUser = await getLoginUser();
    if (loginUser != null) {
      await deleteLoginUser(loginUser);
    }

    return preferences.setBool(authKey, false);
  }

  Future<void> register(String name, String email, String pass) async {
    final result = await _apiService.registerUser(name, email, pass);
    final resData = BaseResponse.fromJson(result);
    // debugPrint('Login result: $result');
    debugPrint('Login result: ${resData.message}');
  }

  Future<bool> saveLoginUser(LoginResult loginUser) async {
    debugPrint('Saving login user: ${loginUser.toJson()}');
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(loginUserKey, loginUser.toJson());
  }

  Future<bool> deleteLoginUser(LoginResult loginUser) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(loginUserKey, "");
  }

  Future<LoginResult?> getLoginUser() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(loginUserKey);
    debugPrint('Login user: $jsonString');
    if (jsonString != null && jsonString.isNotEmpty) {
      return LoginResult.fromJson(jsonString);
    }
    return null;
  }
}
