import 'package:flutter/material.dart';
import 'package:story_app/data/api_service.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/screens/splash_view.dart';
import 'package:story_app/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ApiService _apiService;
  late final AuthRepository _authRepository;
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _authRepository = AuthRepository(service: _apiService);
    _authProvider = AuthProvider(authRepo: _authRepository);
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO CHANGE
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        Provider(
          create: (context) => AuthRepository(
            service: Provider.of<ApiService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepo: Provider.of<AuthRepository>(context, listen: false),
          ),
        ),
      ],
      child: const MyApp(),
    );

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
