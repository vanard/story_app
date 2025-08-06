import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
