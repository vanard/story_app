import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_helper.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.initialRoute});

  final String? initialRoute;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  String _name = '';
  String _email = '';
  String _password = '';

  late final AuthProvider _authProvider;
  bool? _lastLoginMode;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    debugPrint('Initial route: ${widget.initialRoute}');
    if ((!_authProvider.isLoginMode && widget.initialRoute == '/login') ||
        (_authProvider.isLoginMode && widget.initialRoute == '/register')) {
      _authProvider.toggleLoginMode();
    }

    _authProvider.addListener(_onAuthModeChanged);
    _lastLoginMode = _authProvider.isLoginMode;
  }

  void _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    if (_authProvider.isLoginMode) {
      await _authProvider.login(_email, _password);
    } else {
      await _authProvider.register(_name, _email, _password);
    }

    if (!context.mounted) {
      return;
    }

    if (_authProvider.errorMessage.isNotEmpty) {
      return _showErrorMessage(_authProvider.errorMessage);
    }

    debugPrint(
      'Authentication ${_authProvider.isLoggedIn ? 'successful' : 'failed'}',
    );
  }

  void _showErrorMessage(String msg) {
    _clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _clearSnackBars() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void _onAuthModeChanged() {
    debugPrint('Auth mode changed called');

    final currentLoginMode = _authProvider.isLoginMode;
    final currentIsloggedIn = _authProvider.isLoggedIn;
    if (_lastLoginMode != null && _lastLoginMode != currentLoginMode) {
      debugPrint('Auth mode changed from $_lastLoginMode to $currentLoginMode');
      _formKey.currentState?.reset();

      _name = '';
      _email = '';
      _password = '';
      passController.clear();
    }

    if (currentIsloggedIn) {
      context.replaceWith(MainPageConfiguration(bottomNavIndex: 0));
    }
  }

  @override
  void dispose() {
    passController.dispose();

    _authProvider.removeListener(_onAuthModeChanged);
    _clearSnackBars();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(size: 100.0),
                  SizedBox(height: 40.0),
                  if (!provider.isLoginMode)
                    TextFormField(
                      decoration: textFieldInputDecoration(
                        appLocalizations.namaLabel,
                        appLocalizations.hintNamaLabel,
                      ),
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return appLocalizations.namaRequired;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: textFieldInputDecoration(
                      appLocalizations.emailLabel,
                      appLocalizations.hintEmailLabel,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return appLocalizations.emailRequired;
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return appLocalizations.emailInvalid;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: passController,
                    decoration: textFieldInputDecoration(
                      appLocalizations.passwordLabel,
                      appLocalizations.hintPasswordLabel,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return appLocalizations.passwordRequired;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  if (!provider.isLoginMode) SizedBox(height: 12.0),
                  if (!provider.isLoginMode)
                    TextFormField(
                      decoration: textFieldInputDecoration(
                        appLocalizations.confirmPasswordLabel,
                        appLocalizations.hintConfirmPasswordLabel,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null || value != passController.text) {
                          return appLocalizations.confirmPasswordRequired;
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _confirmPassword = value!;
                      // },
                    ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: provider.isLoading ? () {} : _submit,
                    child: provider.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            provider.isLoginMode
                                ? appLocalizations.loginButton
                                : appLocalizations.registerButton,
                          ),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      text:
                          "${provider.isLoginMode ? appLocalizations.donthaveAccount : appLocalizations.alreadyHaveAccount} ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      children: [
                        TextSpan(
                          text: provider.isLoginMode
                              ? appLocalizations.registerButton
                              : appLocalizations.loginButton,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = provider.isLoading
                                ? () {}
                                : () {
                                    // _formKey.currentState?.reset();
                                    provider.toggleLoginMode();
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                  },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldInputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Theme.of(context).hintColor.withValues(alpha: 0.6),
      ),
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.5,
        ),
      ),
    );
  }
}
