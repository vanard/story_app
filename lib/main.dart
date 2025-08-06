import 'package:flutter/material.dart';
import 'package:story_app/screens/splash_view.dart';
import 'package:story_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme.copyWith(textTheme: baseTextTheme(context, lightTheme)),
      darkTheme: darkTheme.copyWith(
        textTheme: baseTextTheme(context, darkTheme),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
