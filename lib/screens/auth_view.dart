import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:story_app/l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoginMode = true;

  void submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 100.0),
              SizedBox(height: 40.0),
              if (!isLoginMode)
                TextFormField(
                  // decoration: InputDecoration(
                  //   labelText: appLocalizations.namaLabel,
                  //   hintText: appLocalizations.hintNamaLabel,
                  //   hintStyle: TextStyle(
                  //     color: Theme.of(context).hintColor.withValues(alpha: 0.6),
                  //   ),
                  // ),
                  decoration: textFieldInputDecoration(
                    appLocalizations.namaLabel,
                    appLocalizations.hintNamaLabel,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocalizations.namaRequired;
                    }
                    return null;
                  },
                ),
              SizedBox(height: 12.0),
              TextFormField(
                // decoration: InputDecoration(
                //   labelText: appLocalizations.emailLabel,
                //   hintText: appLocalizations.hintEmailLabel,
                //   hintStyle: TextStyle(
                //     color: Theme.of(context).hintColor.withValues(alpha: 0.6),
                //   ),
                // ),
                decoration: textFieldInputDecoration(
                  appLocalizations.emailLabel,
                  appLocalizations.hintEmailLabel,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.emailRequired;
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return appLocalizations.emailInvalid;
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                // decoration: InputDecoration(
                //   labelText: appLocalizations.passwordLabel,
                //   hintText: appLocalizations.hintPasswordLabel,
                //   hintStyle: TextStyle(
                //     color: Theme.of(context).hintColor.withValues(alpha: 0.6),
                //   ),
                // ),
                decoration: textFieldInputDecoration(
                  appLocalizations.passwordLabel,
                  appLocalizations.hintPasswordLabel,
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return appLocalizations.passwordRequired;
                  }
                  return null;
                },
              ),
              if (!isLoginMode) SizedBox(height: 12.0),
              if (!isLoginMode)
                TextFormField(
                  decoration: textFieldInputDecoration(
                    appLocalizations.confirmPasswordLabel,
                    appLocalizations.hintConfirmPasswordLabel,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null) {
                      return appLocalizations.confirmPasswordRequired;
                    }
                    return null;
                  },
                ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  isLoginMode
                      ? appLocalizations.loginButton
                      : appLocalizations.registerButton,
                ),
              ),
              SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  text:
                      "${isLoginMode ? appLocalizations.donthaveAccount : appLocalizations.alreadyHaveAccount} ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: [
                    TextSpan(
                      text: isLoginMode
                          ? appLocalizations.signupButton
                          : appLocalizations.loginButton,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isLoginMode = !isLoginMode;
                          });
                        },
                    ),
                  ],
                ),
              ),
            ],
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
    );
  }
}
