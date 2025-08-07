import 'package:flutter/foundation.dart';
import 'package:story_app/db/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  late final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepo}) : _authRepository = authRepo;
}
