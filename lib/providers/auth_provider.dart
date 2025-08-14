import 'package:flutter/foundation.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/models/login_result.dart';

class AuthProvider extends ChangeNotifier {
  late final AuthRepository _authRepository;
  bool _isLoading = false;
  bool _isLoginMode = true;
  bool _isLoggedIn = false;
  String _errorMessage = '';
  LoginResult? _loginUser;

  AuthProvider({required AuthRepository authRepository})
    : _authRepository = authRepository;

  bool get isLoading => _isLoading;
  bool get isLoginMode => _isLoginMode;
  bool get isLoggedIn => _isLoggedIn;
  String get errorMessage => _errorMessage;
  LoginResult? get loginUser => _loginUser;

  void toggleLoginMode() {
    _isLoginMode = !_isLoginMode;
    notifyListeners();
  }

  Future<bool> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoggedIn = await _authRepository.isLoggedIn();
      // if (_isLoggedIn) {
      //   final loginUser = await _authRepository.getLoginUser();
      //   if (loginUser != null) {
      //     // Handle the logged-in user
      //   }
      // }
      debugPrint('Is logged in: $_isLoggedIn');
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error checking login status: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return _isLoggedIn;
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoggedIn = await _authRepository.login(email, password);
      // if (_isLoggedIn) {
      //   final loginUser = await _authRepository.getLoginUser();
      //   if (loginUser != null) {
      //     await _authRepository.saveLoginUser(loginUser);
      //   }
      // }
      debugPrint('Login successful: $_isLoggedIn');
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error during login: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      // final result = 
      await _authRepository.register(
        name,
        email,
        password,
      ); 
      debugPrint('Registration successful');
      // _isLoginMode = true; // Switch to login mode after registration
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error during registration: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoggedIn = await _authRepository.logout();
      debugPrint('Logout successful: $_isLoggedIn');
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error during logout: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getLoginUser() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userData = await _authRepository.getLoginUser();
      debugPrint('User: $userData');
      _loginUser = userData;
    } catch (e) {
      _errorMessage = e.toString().split('Exception:').last.trim();
      debugPrint('Error during logout: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
