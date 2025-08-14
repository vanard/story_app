// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleAppBar => 'Story App';

  @override
  String get loginButton => 'Login';

  @override
  String get registerButton => 'Register';

  @override
  String get logoutButton => 'Logout';

  @override
  String get settingsButton => 'Settings';

  @override
  String get namaLabel => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get hintNamaLabel => 'Enter your name';

  @override
  String get hintEmailLabel => 'Enter your email';

  @override
  String get hintPasswordLabel => 'Enter your password';

  @override
  String get hintConfirmPasswordLabel => 'Confirm your password';

  @override
  String get donthaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get errorLogin => 'Login failed, please try again.';

  @override
  String get errorRegister => 'Registration failed, please try again.';

  @override
  String get namaRequired => 'Name is required.';

  @override
  String get emailRequired => 'Email is required.';

  @override
  String get emailInvalid => 'Invalid email address.';

  @override
  String get passwordRequired => 'Password must be at least 8 characters.';

  @override
  String get confirmPasswordRequired => 'Confirm password is required.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get areYouSure => 'Are you sure you want to log out?';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';
}
