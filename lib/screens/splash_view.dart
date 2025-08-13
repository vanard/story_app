import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onAuthCheckComplete});

  final void Function(bool isLoggedIn)? onAuthCheckComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).checkLoginStatus();
    if (widget.onAuthCheckComplete != null) {
      widget.onAuthCheckComplete!(isLoggedIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 100.0),
            SizedBox(height: 16.0),
            Text('Story App', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16.0),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
